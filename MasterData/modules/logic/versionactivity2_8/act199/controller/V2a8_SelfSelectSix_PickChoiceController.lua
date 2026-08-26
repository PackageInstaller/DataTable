-- chunkname: @modules/logic/versionactivity2_8/act199/controller/V2a8_SelfSelectSix_PickChoiceController.lua

module("modules.logic.versionactivity2_8.act199.controller.V2a8_SelfSelectSix_PickChoiceController", package.seeall)

local V2a8_SelfSelectSix_PickChoiceController = class("V2a8_SelfSelectSix_PickChoiceController", BaseController)

function V2a8_SelfSelectSix_PickChoiceController:onInit()
	self._pickHandler = nil
	self._pickHandlerObj = nil
	self._showMsgBoxFunc = nil
	self._showMsgBoxFuncObj = nil
	self._tmpViewParam = nil
end

function V2a8_SelfSelectSix_PickChoiceController:onInitFinish()
	return
end

function V2a8_SelfSelectSix_PickChoiceController:addConstEvents()
	return
end

function V2a8_SelfSelectSix_PickChoiceController:reInit()
	self:onInit()
end

function V2a8_SelfSelectSix_PickChoiceController:onOpenView()
	self:dispatchEvent(V2a8_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged)
end

function V2a8_SelfSelectSix_PickChoiceController:setSelect(heroId)
	local isSelected = V2a8_SelfSelectSix_PickChoiceListModel.instance:isHeroIdSelected(heroId)
	local selectCount = V2a8_SelfSelectSix_PickChoiceListModel.instance:getSelectCount()
	local maxSelectCount = V2a8_SelfSelectSix_PickChoiceListModel.instance:getMaxSelectCount()

	if not isSelected and maxSelectCount <= selectCount then
		if maxSelectCount > 1 then
			GameFacade.showToast(ToastEnum.CustomPickPleaseCancel)

			return
		else
			V2a8_SelfSelectSix_PickChoiceListModel.instance:clearAllSelect()
		end
	end

	V2a8_SelfSelectSix_PickChoiceListModel.instance:setSelectId(heroId)
	self:dispatchEvent(V2a8_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged)
end

function V2a8_SelfSelectSix_PickChoiceController:tryChoice(viewParam)
	local maxSelectCount = V2a8_SelfSelectSix_PickChoiceListModel.instance:getMaxSelectCount()
	local selectCount = V2a8_SelfSelectSix_PickChoiceListModel.instance:getSelectCount()

	if not selectCount or maxSelectCount < selectCount then
		return false
	end

	if selectCount < maxSelectCount then
		GameFacade.showToast(ToastEnum.NoChoiceHero)

		return false
	end

	self._tmpViewParam = viewParam

	if self._showMsgBoxFunc then
		if self._showMsgBoxFuncObj then
			self._showMsgBoxFunc(self._showMsgBoxFuncObj, self.realChoice, self)
		else
			self._showMsgBoxFunc(self.realChoice, self)
		end
	else
		local heroNames
		local hasHero = false
		local selectList = V2a8_SelfSelectSix_PickChoiceListModel.instance:getSelectIds()

		if selectList then
			for _, heroId in ipairs(selectList) do
				local heroMo = HeroModel.instance:getByHeroId(heroId)

				if not hasHero and heroMo then
					hasHero = true
				end

				local heroConfig = HeroConfig.instance:getHeroCO(heroId)

				if heroConfig then
					if heroConfig then
						if not heroConfig.name then
							local name = ""

							heroNames = string.nilorempty(heroNames) and name or GameUtil.getSubPlaceholderLuaLang(luaLang("custompickchoice_select_heros"), {
								heroNames,
								name
							})
						end
					end
				end
			end
		end

		if hasHero then
			if not MessageBoxIdDefine.V2a8_SelfSelectSix_PickChoiceHasHero then
				local msgBoxId = MessageBoxIdDefine.V2a8_SelfSelectSix_PickChoiceConfirm

				GameFacade.showMessageBox(msgBoxId, MsgBoxEnum.BoxType.Yes_No, self.realChoice, nil, nil, self, nil, nil, heroNames)
			end
		end
	end
end

function V2a8_SelfSelectSix_PickChoiceController:realChoice()
	local activityId = V2a8_SelfSelectSix_PickChoiceListModel.instance:getActivityId()
	local selectList = V2a8_SelfSelectSix_PickChoiceListModel.instance:getSelectIds()
	local heroId = selectList[1]

	Activity199Rpc.instance:sendAct199GainRequest(activityId, heroId)
end

function V2a8_SelfSelectSix_PickChoiceController:onCloseView()
	return
end

V2a8_SelfSelectSix_PickChoiceController.instance = V2a8_SelfSelectSix_PickChoiceController.New()

return V2a8_SelfSelectSix_PickChoiceController
