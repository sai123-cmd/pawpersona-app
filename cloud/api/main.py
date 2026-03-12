"""
PawPersona Backend API
FastAPI-based backend for pet wearable device
"""

from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel
from typing import Optional, List
from datetime import datetime
import os

app = FastAPI(title="PawPersona API", version="1.0.0")

# ============== Models ==============

class User(BaseModel):
    id: Optional[int] = None
    phone: str
    nickname: Optional[str] = None
    avatar: Optional[str] = None
    created_at: Optional[datetime] = None

class Video(BaseModel):
    id: Optional[int] = None
    user_id: int
    oss_key: str
    duration: Optional[int] = 0
    status: str = "processing"
    ai_task_id: Optional[int] = None
    created_at: Optional[datetime] = None

class Device(BaseModel):
    id: Optional[int] = None
    user_id: int
    device_sn: str
    name: Optional[str] = None
    status: str = "offline"

class AITask(BaseModel):
    id: Optional[int] = None
    video_id: int
    type: str
    status: str = "pending"
    result: Optional[dict] = None
    created_at: Optional[datetime] = None

# ============== API Endpoints ==============

@app.get("/")
def root():
    return {"message": "PawPersona API v1.0", "status": "running"}

# --- Auth ---
@app.post("/api/auth/register")
def register(user: User):
    """User registration"""
    return {"token": "mock_token_" + str(datetime.now().timestamp())}

@app.post("/api/auth/login")
def login(phone: str, password: str):
    """User login"""
    return {"token": "mock_token_" + str(datetime.now().timestamp()), "user_id": 1}

# --- Video ---
@app.post("/api/videos/upload")
def get_upload_credential(user_id: int):
    """Get OSS upload credential"""
    return {
        "access_key_id": "STS.xxx",
        "access_key_secret": "xxx",
        "security_token": "xxx",
        "bucket": "pawpersona-videos",
        "region": "oss-cn-hangzhou"
    }

@app.get("/api/videos")
def list_videos(user_id: int, page: int = 1, page_size: int = 20):
    """List user videos"""
    return {
        "items": [],
        "total": 0,
        "page": page,
        "page_size": page_size
    }

@app.get("/api/videos/{video_id}")
def get_video(video_id: int):
    """Get video detail"""
    return {
        "id": video_id,
        "url": "https://pawpersona-videos.oss-cn-hangzhou.com/xxx.mp4",
        "duration": 15,
        "status": "ready"
    }

# --- AI ---
@app.post("/api/ai/detect")
def start_ai_detection(video_id: int, detection_type: str = "pet行为"):
    """Start AI detection"""
    return {"task_id": 1, "status": "processing"}

@app.get("/api/ai/result/{task_id}")
def get_ai_result(task_id: int):
    """Get AI detection result"""
    return {
        "task_id": task_id,
        "status": "completed",
        "result": {"pet_status": "正常", "confidence": 0.95}
    }

# --- Device ---
@app.post("/api/devices/bind")
def bind_device(user_id: int, device_sn: str, name: str):
    """Bind device to user"""
    return {"device_id": 1, "status": "online"}

@app.get("/api/devices")
def list_devices(user_id: int):
    """List user devices"""
    return {"items": []}

@app.get("/api/devices/{device_id}/location")
def get_device_location(device_id: int):
    """Get device GPS location"""
    return {
        "lat": 30.2741,
        "lng": 120.1551,
        "accuracy": 5,
        "timestamp": datetime.now().isoformat()
    }

# --- Callback ---
@app.post("/api/callback/oss")
def oss_callback():
    """OSS upload callback"""
    return {"code": "Success"}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
