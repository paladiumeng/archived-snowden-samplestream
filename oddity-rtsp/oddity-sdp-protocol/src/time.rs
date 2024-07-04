use std::time::{SystemTime, UNIX_EPOCH};

pub fn unix_epoch_timestamp() -> u64 {
    SystemTime::now()
        .duration_since(UNIX_EPOCH)
        .unwrap_or_default()
        .as_secs()
}
