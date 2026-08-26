-- chunkname: @modules/logic/sp01/odyssey/define/OdysseyEvent.lua

module("modules.logic.sp01.odyssey.define.OdysseyEvent", package.seeall)

local OdysseyEvent = _M

OdysseyEvent.OnCreateMapRootGoDone = 10000
OdysseyEvent.OnLoadSceneFinish = 10001
OdysseyEvent.OnInitElements = 10002
OdysseyEvent.OnDisposeScene = 10003
OdysseyEvent.OnUpdateElementArrow = 10004
OdysseyEvent.OnClickElement = 10005
OdysseyEvent.OnFocusElement = 10006
OdysseyEvent.OnElementFinish = 10007
OdysseyEvent.RefreshDungeonView = 10008
OdysseyEvent.OnUpdateElementPush = 10009
OdysseyEvent.OnDisposeOldMap = 10010
OdysseyEvent.OnInitMapSelect = 10011
OdysseyEvent.OnClickMapSelectItem = 10012
OdysseyEvent.OnFocusMapSelectItem = 10013
OdysseyEvent.OnMapSelectItemEnter = 10014
OdysseyEvent.OnRewardGet = 10015
OdysseyEvent.ShowAddExpEffect = 10016
OdysseyEvent.JumpNeedOpenElement = 10017
OdysseyEvent.CreateNewElement = 10018
OdysseyEvent.JumpToHeroPos = 10019
OdysseyEvent.SetDungeonUIShowState = 10020
OdysseyEvent.OnMapUpdate = 10021
OdysseyEvent.PlayElementAnim = 10022
OdysseyEvent.ShowDungeonRightUI = 10023
OdysseyEvent.ShowInteractCloseBtn = 10024
OdysseyEvent.OnCloseDungeonRewardView = 10025
OdysseyEvent.PlaySubTaskFinishEffect = 10026
OdysseyEvent.PlaySubTaskShowEffect = 10027
OdysseyEvent.RefreshMercenarySuit = 10101
OdysseyEvent.RefreshTalent = 10201
OdysseyEvent.RefreshTalentNodeSelect = 10202
OdysseyEvent.ResetTalent = 10203
OdysseyEvent.TrialTalentTreeChange = 10204
OdysseyEvent.TrialTalentTreeReset = 10205
OdysseyEvent.RefreshReligionMembers = 10301
OdysseyEvent.RefreshHeroInfo = 10302
OdysseyEvent.ShowExposeEffect = 10303
OdysseyEvent.DailyRefresh = 20000
OdysseyEvent.OdysseyTaskUpdated = 20001
OdysseyEvent.OdysseyTaskRefresh = 20002
OdysseyEvent.OnTaskRewardGetFinish = 20003
OdysseyEvent.OnRefreshReddot = 20004
OdysseyEvent.OnRefreshHeroLevel = 20005
OdysseyEvent.OnHeroGroupSwitch = 30000
OdysseyEvent.OnHeroGroupSave = 30001
OdysseyEvent.OnHeroGroupUpdate = 30002
OdysseyEvent.OnTipSubViewOpen = 30003
OdysseyEvent.OnTipSubViewClose = 30004
OdysseyEvent.OnEquipItemSelect = 40000
OdysseyEvent.OnEquipSuitSelect = 40001
OdysseyEvent.OnEquipPosSelect = 40002
OdysseyEvent.OnRefreshBagReddot = 40003
OdysseyEvent.ShowDungeonBagGetEffect = 50000
OdysseyEvent.ShowDungeonTalentGetEffect = 50001
OdysseyEvent.MythUnlockGuide = 60000

return OdysseyEvent
