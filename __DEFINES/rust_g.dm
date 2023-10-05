// -- Borrowed from various authors from TGStation - https://github.com/tgstation/tgstation

// rust_g.dm - DM API for rust_g extension library
//
// To configure, create a `rust_g.config.dm` and set what you care about from
// the following options:
//
// #define RUST_G "path/to/rust_g"
// Override the .dll/.so detection logic with a fixed path or with detection
// logic of your own.
//
// #define RUSTG_OVERRIDE_BUILTINS
// Enable replacement rust-g functions for certain builtins. Off by default.

#ifndef RUST_G
// Default automatic RUST_G detection.
// On Windows, looks in the standard places for `rust_g.dll`.
// On Linux, looks in `.`, `$LD_LIBRARY_PATH`, and `~/.byond/bin` for either of
// `librust_g.so` (preferred) or `rust_g` (old).

/* This comment bypasses grep checks */ /var/__rust_g

/proc/__detect_rust_g()
	if (world.system_type == UNIX)
		if (fexists("./librust_g.so"))
			// No need for LD_LIBRARY_PATH badness.
			return __rust_g = "./librust_g.so"
		else if (fexists("./rust_g"))
			// Old dumb filename.
			return __rust_g = "./rust_g"
		else if (fexists("[world.GetConfig("env", "HOME")]/.byond/bin/rust_g"))
			// Old dumb filename in `~/.byond/bin`.
			return __rust_g = "rust_g"
		else
			// It's not in the current directory, so try others
			return __rust_g = "librust_g.so"
	else
		return __rust_g = "rust_g"

#define RUST_G (__rust_g || __detect_rust_g())
#endif

#define RUSTG_JOB_NO_RESULTS_YET "NO RESULTS YET"
#define RUSTG_JOB_NO_SUCH_JOB "NO SUCH JOB"
#define RUSTG_JOB_ERROR "JOB PANICKED"

#define rustg_dmi_strip_metadata(fname) call_ext(RUST_G, "dmi_strip_metadata")(fname)
#define rustg_dmi_create_png(path, width, height, data) call_ext(RUST_G, "dmi_create_png")(path, width, height, data)

#define rustg_noise_get_at_coordinates(seed, x, y) call_ext(RUST_G, "noise_get_at_coordinates")(seed, x, y)

#define rustg_git_revparse(rev) call_ext(RUST_G, "rg_git_revparse")(rev)
#define rustg_git_commit_date(rev) call_ext(RUST_G, "rg_git_commit_date")(rev)

#define rustg_log_write(fname, text, format) call_ext(RUST_G, "log_write")(fname, text, format)
/proc/rustg_log_close_all() return call_ext(RUST_G, "log_close_all")()

#define RUSTG_HTTP_METHOD_GET "get"
#define RUSTG_HTTP_METHOD_PUT "put"
#define RUSTG_HTTP_METHOD_DELETE "delete"
#define RUSTG_HTTP_METHOD_PATCH "patch"
#define RUSTG_HTTP_METHOD_HEAD "head"
#define RUSTG_HTTP_METHOD_POST "post"
#define rustg_http_request_blocking(method, url, body, headers) call_ext(RUST_G, "http_request_blocking")(method, url, body, headers)
#define rustg_http_request_async(method, url, body, headers) call_ext(RUST_G, "http_request_async")(method, url, body, headers)
#define rustg_http_check_request(req_id) call_ext(RUST_G, "http_check_request")(req_id)

#define rustg_sql_connect_pool(options) call_ext(RUST_G, "sql_connect_pool")(options)
#define rustg_sql_query_async(handle, query, params) call_ext(RUST_G, "sql_query_async")(handle, query, params)
#define rustg_sql_query_blocking(handle, query, params) call_ext(RUST_G, "sql_query_blocking")(handle, query, params)
#define rustg_sql_connected(handle) call_ext(RUST_G, "sql_connected")(handle)
#define rustg_sql_disconnect_pool(handle) call_ext(RUST_G, "sql_disconnect_pool")(handle)
#define rustg_sql_check_query(job_id) call_ext(RUST_G, "sql_check_query")("[job_id]")
