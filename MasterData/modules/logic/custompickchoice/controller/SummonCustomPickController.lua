-- chunkname: @modules/logic/custompickchoice/controller/SummonCustomPickController.lua

module("modules.logic.custompickchoice.controller.SummonCustomPickController", package.seeall)

local SummonCustomPickController = class("SummonCustomPickController", BaseController)

function SummonCustomPickController:openSummonCustomPickView(bePickChoiceHeroIdList, pickHandler, pickHandlerObj, viewParam, showMsgBoxFunc, showMsgBoxFuncObj, maxSelectCount)
	self._pickHandler = pickHandler
	self._pickHandlerObj = pickHandlerObj
	self._showMsgBoxFunc = showMsgBoxFunc
	self._showMsgBoxFuncObj = showMsgBoxFuncObj
	maxSelectCount = maxSelectCount or 1

	SummonCustomPickHeroModel.instance:initData(bePickChoiceHeroIdList, maxSelectCount)

	local haveAllRole = SummonCustomPickHeroModel.instance:haveAllRole()

	self._itemData = viewParam

	if haveAllRole then
		ViewMgr.instance:openView(ViewName.SummonCustomPickView, viewParam)
	else
		self:trySendSummon(viewParam)
	end
end

function SummonCustomPickController:trySendChoice(viewParam)
	self._itemData = viewParam or self._itemData

	local selectList = SummonCustomPickHeroModel.instance:getSelectIds()

	if not selectList then
		GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)

		return false
	end

	local maxSelectCount = SummonCustomPickHeroModel.instance:getMaxSelectCount()

	if maxSelectCount > #selectList then
		if maxSelectCount == 1 then
			GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)
		end

		return false
	end

	local heroNameStr = self:getSelectHeroNameStr(selectList)

	GameFacade.showMessageBox(MessageBoxIdDefine.SummonLuckyBagSelectChar, MsgBoxEnum.BoxType.Yes_No, self.realSendChoice, nil, nil, self, nil, nil, heroNameStr, "")
end

function SummonCustomPickController:realSendChoice()
	local selectList = SummonCustomPickHeroModel.instance:getSelectIds()
	local heroId = selectList[1]
	local data = {}
	local o = {}

	o.materialId = self._itemData.id
	o.quantity = self._itemData.quantity

	table.insert(data, o)
	ItemRpc.instance:sendUseItemRequest(data, heroId)
end

function SummonCustomPickController:trySendSummon()
	GameFacade.showMessageBox(MessageBoxIdDefine.Act167SummonNeTip, MsgBoxEnum.BoxType.Yes_No, self.realSendSummon, nil, nil, self)
end

function SummonCustomPickController:realSendSummon()
	CharacterModel.instance:setGainHeroViewShowState(true)
	self.registerCallback(self, SummonCustomPickEvent.OnSummonCustomGet, self.onSummonCustomGet, self)

	local data = {}
	local o = {}

	o.materialId = self._itemData.id
	o.quantity = self._itemData.quantity

	table.insert(data, o)
	ItemRpc.instance:sendUseItemRequest(data, 0)
end

function SummonCustomPickController:onSummonCustomGet(heroId)
	if not SummonCustomPickHeroModel.instance:haveAllRole() then
		self:enterSummon(tonumber(heroId))
	end

	self.unregisterCallback(self, SummonCustomPickEvent.OnSummonCustomGet, self.onSummonCustomGet, self)
end

function SummonCustomPickController:enterSummon(heroId)
	ViewMgr.instance:closeAllPopupViews()

	self._heroId = heroId

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._onCloseView, self)
	SummonController.instance:simpleEnterSummonScene({
		heroId
	}, self._onBackSummon, self)
end

function SummonCustomPickController:_onBackSummon()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		MainController.instance:enterMainScene(true)
	end

	VirtualSummonScene.instance:close(true)
end

function SummonCustomPickController:_onCloseView(viewName)
	if viewName ~= ViewName.CharacterGetView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._onCloseView, self)

	if not self._heroId then
		return
	end

	local mo = MaterialDataMO.New()

	mo:initValue(MaterialEnum.MaterialType.Hero, self._heroId, 1)

	local materialDataMOList = {
		mo
	}

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, materialDataMOList)
	CharacterModel.instance:setGainHeroViewShowState(false)
end

function SummonCustomPickController:getSelectHeroNameStr(selectList)
	local heroNameStr = ""

	for i = 1, #selectList do
		local heroCo = HeroConfig.instance:getHeroCO(selectList[i])

		heroNameStr = i == 1 and heroCo.name or heroNameStr .. ", " .. heroCo.name
	end

	return heroNameStr
end

function SummonCustomPickController:setSelect(heroId)
	local selectList = SummonCustomPickHeroModel.instance:getSelectIds()
	local maxSelectCount = SummonCustomPickHeroModel.instance:getMaxSelectCount()

	if not SummonCustomPickHeroModel.instance:isHeroIdSelected(heroId) and maxSelectCount <= #selectList and maxSelectCount == 1 then
		SummonCustomPickHeroModel.instance:clearSelectIds()
	end

	SummonCustomPickHeroModel.instance:setSelectId(heroId)
	self:dispatchEvent(SummonCustomPickEvent.OnCustomPickListChanged)
end

SummonCustomPickController.instance = SummonCustomPickController.New()

LuaEventSystem.addEventMechanism(SummonCustomPickController.instance)

return SummonCustomPickController
