import pandas as pd
import random
from datetime import datetime, timedelta

rows = []
steps = ["start","phone_entry","otp","personal_details","kyc_upload","account_created"]
channels = ["Mobile App","USSD","Web","Branch"]
statuses = ["success","fail","abandon"]

for i in range(15000):
    customer = f"+2783{random.randint(1000000,9999999)}"
    step_seq = random.randint(1,6)
    
    rows.append({
        "event_id": i,
        "event_timestamp": datetime.now() - timedelta(minutes=random.randint(0,10000)),
        "event_name": steps[step_seq-1],
        "event_type": "progress",
        "customer_identifier": customer,
        "session_id": f"S{random.randint(1,3000)}",
        "attempt_id": f"A{random.randint(1,5000)}",
        "channel": random.choice(channels),
        "device_type": random.choice(["Android","ios"]),
        "os": random.choice(["Android 11","ios 26"]),
        "network_type": random.choice(["3G","4G"]),
        "step_name": steps[step_seq-1],
        "step_sequence": step_seq,
        "status": random.choice(statuses),
        "error_code": None,
        "location_raw":random.choice(["Durban","johannesburg","Cape town"]),
        "ingestion_timestamp": datetime.now(),
        "source_system": "app"
    })

df = pd.DataFrame(rows)
df.to_csv("raw_onboarding_events.csv", index=False)