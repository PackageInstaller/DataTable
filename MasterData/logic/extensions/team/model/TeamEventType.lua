-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/model/TeamEventType.lua

module("logic.extensions.team.model.TeamEventType", package.seeall)

local TeamEventType = {}

TeamEventType.ON_SCENE_ROTATE_START = UIDUtil.getEventUID()
TeamEventType.ON_SCENE_ROTATE_END = UIDUtil.getEventUID()
TeamEventType.ON_SCENE_SCALE_RING_POSZ = UIDUtil.getEventUID()
TeamEventType.ON_SCENE_SCALE_RING_UPDATE_UI = UIDUtil.getEventUID()
TeamEventType.ON_SCENE_CHANGE_RING_TYPE = UIDUtil.getEventUID()
TeamEventType.ON_SCENE_CAMERA_REFRESH = UIDUtil.getEventUID()
TeamEventType.Adjustment_OnClearOperateUnit = UIDUtil.getEventUID()
TeamEventType.ON_HERO_HIT = UIDUtil.getEventUID()
TeamEventType.ON_HIDE_ROLE_TIPS = UIDUtil.getEventUID()

return TeamEventType
