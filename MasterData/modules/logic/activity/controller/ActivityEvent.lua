-- chunkname: @modules/logic/activity/controller/ActivityEvent.lua

module("modules.logic.activity.controller.ActivityEvent", package.seeall)

local ActivityEvent = {}

ActivityEvent.GetActivityInfoSuccess = 11
ActivityEvent.RefreshActivitySelectState = 12
ActivityEvent.RefreshActivityState = 13
ActivityEvent.UpdateActivity = 14
ActivityEvent.RefreshNorSignActivity = 21
ActivityEvent.Refresh109ActivityData = 1
ActivityEvent.Play109EntryViewOpenAni = 2
ActivityEvent.ChangeActivityStage = 100
ActivityEvent.CheckGuideOnEndActivity = 101
ActivityEvent.SetBannerViewCategoryListInteract = 201
ActivityEvent.RefreshDoubleDropInfo = 202
ActivityEvent.SwitchWelfareActivity = 301
ActivityEvent.UnlockPermanent = 401
ActivityEvent.GetActivityInfoWithParamSuccess = 402
ActivityEvent.Act172TaskUpdate = 50001

return ActivityEvent
