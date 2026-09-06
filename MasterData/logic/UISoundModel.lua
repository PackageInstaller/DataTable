-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/uisound/model/UISoundModel.lua

module("logic.extensions.uisound.model.UISoundModel", package.seeall)

local UISoundModel = class("UISoundModel", BaseListModel)
local spriteSoundIds = {
	com_huobi02 = 30005,
	com_btn_tiaozhan01 = 30012,
	hud_bg06 = 30006
}
local gameObjectSoundIds = {
	Nego_Info = 30114,
	cell_9 = 30102,
	cell_43 = 30101,
	Btn_Clean = 30010,
	Btn_OneKey = 30009,
	cell_95 = 30112,
	cell_8 = 30104,
	ImgC_Head = 30110,
	cell_99 = 30109,
	cell_10 = 30103,
	cell_47 = 30109,
	cell_72 = 30100,
	cell_64 = 30105,
	btnOneKey = 30009,
	btnClean = 30010,
	imgToLogin = 30011,
	cell_2 = 30109,
	cell_60 = 30107,
	cell_7 = 30106
}
local funcObjectSoundIds = {
	"Btn_Mail",
	"Btn_Friend",
	"Btn_Actions",
	"Btn_Chat",
	"cell_"
}
local backSoundsUIName = {
	"_back",
	"fanhui"
}
local closeSoundsUIName = {
	"_close",
	"guanbi"
}
local tabSoundsUIName = {
	"_tab",
	"tab_"
}
local addSoundsUIName = {
	"_add",
	"+",
	"jiahao"
}
local ingoreSoundViews = {
	ViewName.Battle,
	ViewName.FavorChange,
	ViewName.TaskCompelete,
	ViewName.PetIntroductionView,
	ViewName.FuncOpen,
	ViewName.BattleStart,
	ViewName.PlayerStrength,
	ViewName.BattleSettlementSuccess,
	ViewName.BattleSettlementFail,
	ViewName.BattleSettlementFailSimple,
	ViewName.DrawcardresultView,
	ViewName.ItemGet,
	ViewName.PetDisplay,
	ViewName.LotteryeffectView,
	ViewName.SummerLotteryEffectView,
	ViewName.GMView
}

function UISoundModel:onInit()
	UnlockModel.super.onInit(self)
end

function UISoundModel:getClickSoundId(gameObject, spName)
	local goName = gameObject.name

	if gameObjectSoundIds[goName] then
		return gameObjectSoundIds[goName]
	end

	if spName and spriteSoundIds[spName] then
		return spriteSoundIds[spName]
	end

	if self:_isMatch(spName, backSoundsUIName) or self:_isMatch(goName, backSoundsUIName) then
		return 30002
	end

	if self:_isMatch(spName, closeSoundsUIName) or self:_isMatch(goName, closeSoundsUIName) then
		return 30004
	end

	if self:_isMatch(spName, tabSoundsUIName) or self:_isMatch(goName, tabSoundsUIName) then
		return 30003
	end

	if self:_isMatch(spName, addSoundsUIName) or self:_isMatch(goName, addSoundsUIName) then
		return 30005
	end

	if self:_isActivity(gameObject) then
		return 30113
	end

	if self:_isFuncNode(gameObject) then
		return 30111
	end

	return 30001
end

function UISoundModel:getViewOpenSoundId(view)
	if not view.parentPresentor and view.viewName ~= UIStateManager.instance:getRoot() and not UIStateManager.instance:isInStack(view.viewName) then
		for i = 1, #ingoreSoundViews do
			if ingoreSoundViews[i] == view.viewName then
				return
			end
		end

		return 30108
	end
end

function UISoundModel:_isMatch(goName, names)
	if not goName then
		return false
	end

	local name = string.lower(goName)

	for i = 1, #names do
		if string.find(name, names[i]) then
			return true
		end
	end

	return false
end

function UISoundModel:_isActivity(gameObject)
	local parent = gameObject.transform.parent

	if not parent or parent.gameObject.name ~= "Btn_Container" then
		return false
	end

	parent = parent.parent

	if not parent or parent.gameObject.name ~= "MoveNode" then
		return false
	end

	parent = parent.parent

	if not parent or parent.gameObject.name ~= "Nego_Activity" then
		return false
	end

	return true
end

function UISoundModel:_isFuncNode(gameObject)
	local name = gameObject.name

	for i = 1, #funcObjectSoundIds do
		if string.find(name, funcObjectSoundIds[i]) then
			return true
		end
	end

	return false
end

UISoundModel.instance = UISoundModel.New()

return UISoundModel
