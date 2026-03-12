# PawPersona 🐾

**宠物AI智能穿戴项圈** - 宠物的数字生命伴侣

## 产品简介

PawPersona是一款宠物AI智能穿戴设备，通过多模态AI技术采集、理解和创造，将宠物从"宠物"转化为"数字生命"。

## 核心功能

- 📹 **生命日志** - 自动记录宠物精彩瞬间
- 🗺️ **精准定位** - GPS + UWB室内外精准定位  
- 🤖 **AI分析** - 宠物行为识别与MBTI性格分析
- 🎬 **AI Vlog** - 自动生成宠物精彩视频
- 👥 **社交功能** - UWB近距离宠物社交

## 产品系列

| 版本 | 售价 | 特点 |
|------|------|------|
| Lite | ¥99-149 | GPS基础定位 |
| Standard | ¥199-249 | 视频+AI（主力） |
| Pro | ¥399-499 | 5G+UWB旗舰 |

## 技术架构

- **硬件**：瑞芯微RK3506/RK3588
- **App**：Flutter + Riverpod
- **云端**：阿里云 + AI服务
- **通信**：4G eSIM + BLE + UWB

## 项目结构

```
src/
├── cloud/           # 云端API
├── embedded/        # 嵌入式固件
└── flutter_app/    # 移动App
```

## 文档

- [产品规格说明书](docs/SPEC.md)
- [开发计划](docs/DEVELOPMENT_PLAN.md)
- [技术详细设计](docs/TECHNICAL_DESIGN.md)
- [定价策略](docs/PRICING_STRATEGY.md)

## GitHub

https://github.com/sai123-cmd/pawpersona-app

## License

MIT
