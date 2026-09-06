-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/spineinterface/member/MsEnum.lua

module("logic.extensions.spineinterface.member.MsEnum", package.seeall)

local MsEnum = class("MsEnum")

MsEnum.DataType = {}
MsEnum.DataType.Int = "int"
MsEnum.DataType.Float = "float"
MsEnum.DataType.Bool = "bool"
MsEnum.DataType.Trigger = "trigger"
MsEnum.SpineParamType = {}
MsEnum.SpineParamType.PathConstraint = "Spine.PathConstraint"
MsEnum.SpineParamType.IkConstraint = "Spine.IkConstraint"
MsEnum.SpineParamType.TransformConstraint = "Spine.TransformConstraint"
MsEnum.SpineParamType.Bone = "Spine.Bone"
MsEnum.SpineEventType_Audio = "Audio"
MsEnum.SystemMemberType = {}
MsEnum.SystemMemberType.Property = "property"
MsEnum.SystemMemberType.Field = "field"
MsEnum.SystemMemberType.Method = "method"
MsEnum.MotionType = {}
MsEnum.MotionType.PublicParam = "publicparam"
MsEnum.MotionType.SpineParam = "spineparam"
MsEnum.MotionType.SpineAnim = "spineanim"
MsEnum.MotionType.Event = "event"
MsEnum.MotionType.BehaviorChange = "behaviorchange"
MsEnum.MotionType.Audio = "audio"
MsEnum.MotionType.BoneFollow = "bonefollow"
MsEnum.ParamMgrType = {}
MsEnum.ParamMgrType.Public = MsEnum.MotionType.PublicParam
MsEnum.ParamMgrType.Spine = MsEnum.MotionType.SpineParam
MsEnum.TriggerEvent = {}
MsEnum.TriggerEvent_EnterState = "EnterState"
MsEnum.TriggerEvent_LimitEnterState = "LimitEnterState"
MsEnum.TriggerEvent_Drop = "Drop"
MsEnum.TriggerEvent_BeginDrag = "BeginDrag"
MsEnum.TriggerEvent_EndDrag = "EndDrag"
MsEnum.TriggerEvent_Drag = "Drag"
MsEnum.TriggerEvent_PointerEnter = "PointerEnter"
MsEnum.TriggerEvent_PointerExit = "PointerExit"
MsEnum.TriggerEvent_PointerClick = "PointerClick"
MsEnum.TriggerEvent_PointerPress = "PointerPress"
MsEnum.TriggerEvent_Timer = "Timer"
MsEnum.TriggerType_EnterState = "EnterState"
MsEnum.TriggerType_LimitEnterState = "LimitEnterState"
MsEnum.TriggerType_PointerClick = "PointerClick"
MsEnum.TriggerType_PointerClickSingle = "PointerClickSingle"
MsEnum.TriggerType_PointerClickDouble = "PointerClickDouble"
MsEnum.TriggerType_FreeDrag = "FreeDrag"
MsEnum.TriggerType_DirDrag = "DirDrag"
MsEnum.TriggerType_EventNotify = "EventNotify"
MsEnum.TriggerType_Timer = "Timer"
MsEnum.TriggerTypeBelong = {}
MsEnum.TriggerTypeBelong[MsEnum.TriggerEvent_EnterState] = {
	[MsEnum.TriggerType_EnterState] = MsEnum.TriggerType_EnterState
}
MsEnum.TriggerTypeBelong[MsEnum.TriggerEvent_LimitEnterState] = {
	[MsEnum.TriggerType_LimitEnterState] = MsEnum.TriggerType_LimitEnterState
}
MsEnum.TriggerTypeBelong[MsEnum.TriggerEvent_Drop] = {}
MsEnum.TriggerTypeBelong[MsEnum.TriggerEvent_BeginDrag] = {
	[MsEnum.TriggerType_FreeDrag] = MsEnum.TriggerType_FreeDrag,
	[MsEnum.TriggerType_DirDrag] = MsEnum.TriggerType_DirDrag
}
MsEnum.TriggerTypeBelong[MsEnum.TriggerEvent_EndDrag] = {
	[MsEnum.TriggerType_FreeDrag] = MsEnum.TriggerType_FreeDrag,
	[MsEnum.TriggerType_DirDrag] = MsEnum.TriggerType_DirDrag
}
MsEnum.TriggerTypeBelong[MsEnum.TriggerEvent_Drag] = {
	[MsEnum.TriggerType_FreeDrag] = MsEnum.TriggerType_FreeDrag,
	[MsEnum.TriggerType_DirDrag] = MsEnum.TriggerType_DirDrag
}
MsEnum.TriggerTypeBelong[MsEnum.TriggerEvent_PointerEnter] = {}
MsEnum.TriggerTypeBelong[MsEnum.TriggerEvent_PointerExit] = {}
MsEnum.TriggerTypeBelong[MsEnum.TriggerEvent_PointerClick] = {
	[MsEnum.TriggerType_PointerClick] = MsEnum.TriggerType_PointerClick,
	[MsEnum.TriggerType_PointerClickSingle] = MsEnum.TriggerType_PointerClickSingle,
	[MsEnum.TriggerType_PointerClickDouble] = MsEnum.TriggerType_PointerClickDouble
}
MsEnum.Notify_SpineInterfaceBagExtension = "spineinterfacebagextension"
MsEnum.Notify_SpineSetActive = "spinesetactive"
MsEnum.Notify_CommonPopSpineScreen = "commonpopspinescreen"
MsEnum.Notify_BubblegamePlay = "spineinterfacebubblegame"
MsEnum.Notify_BubblegamePlayStart = "spineinterfacebubblegamestart"
MsEnum.Notify_XiWangShenNvEnvelopeSpineScreenView = "xiwangshennvenvelopespinescreenview"
MsEnum.Notify_FeiNiYaClothesPopWinView = "feiniyaclothespopwinview"
MsEnum.Interaction_BubbleGame_Enter = "BubbleGame_Enter"
MsEnum.Interaction_BubbleGame_Success = "BubbleGame_Success"
MsEnum.Interaction_BubbleGame_Fail = "BubbleGame_Fail"
MsEnum.Interaction_XiWangShenNvEnvelope_Success = "XiWangShenNvEnvelope_Success"
MsEnum.Interaction_XiWangShenNvEnvelope_Fail = "XiWangShenNvEnvelope_Fail"
MsEnum.Interaction_FeiNiYaClothes_Hair_0 = "FeiNiYaClothes_Hair_0"
MsEnum.Interaction_FeiNiYaClothes_Hair_1 = "FeiNiYaClothes_Hair_1"
MsEnum.Interaction_FeiNiYaClothes_Hair_2 = "FeiNiYaClothes_Hair_2"
MsEnum.Interaction_FeiNiYaClothes_Clothes_0 = "FeiNiYaClothes_Clothes_0"
MsEnum.Interaction_FeiNiYaClothes_Clothes_1 = "FeiNiYaClothes_Clothes_1"
MsEnum.Interaction_FeiNiYaClothes_Shoes_0 = "FeiNiYaClothes_Shoes_0"
MsEnum.Interaction_FeiNiYaClothes_Shoes_1 = "FeiNiYaClothes_Shoes_1"
MsEnum.Interaction_FeiNiYaClothes_Shoes_2 = "FeiNiYaClothes_Shoes_2"
MsEnum.Interaction_FeiNiYaClothes_Shoes_3 = "FeiNiYaClothes_Shoes_3"
MsEnum.Interaction_FeiNiYaClothes_Headwear_0 = "FeiNiYaClothes_Headwear_0"
MsEnum.Interaction_FeiNiYaClothes_Headwear_1 = "FeiNiYaClothes_Headwear_1"
MsEnum.Interaction_FeiNiYaClothes_Headwear_2 = "FeiNiYaClothes_Headwear_2"
MsEnum.Interaction_FeiNiYaClothes_Headwear_3 = "FeiNiYaClothes_Headwear_3"
MsEnum.Interaction_FeiNiYaClothes_Headwear_3_Off = "FeiNiYaClothes_Headwear_3_Off"

return MsEnum
