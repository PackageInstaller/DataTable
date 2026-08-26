-- chunkname: @modules/logic/custompickchoice/controller/CustomPickChoiceController.lua

module("modules.logic.custompickchoice.controller.CustomPickChoiceController", package.seeall)

local CustomPickChoiceController = class("CustomPickChoiceController", BaseController)

function CustomPickChoiceController:onInit()
	self._pickHandler = nil
	self._pickHandlerObj = nil
	self._showMsgBoxFunc = nil
	self._showMsgBoxFuncObj = nil
	self._tmpViewParam = nil
end

function CustomPickChoiceController:onInitFinish()
	return
end

function CustomPickChoiceController:addConstEvents()
	return
end

function CustomPickChoiceController:reInit()
	self:onInit()
end

function CustomPickChoiceController:openCustomPickChoiceView(bePickChoiceHeroIdList, pickHandler, pickHandlerObj, viewParam, showMsgBoxFunc, showMsgBoxFuncObj, maxSelectCount)
	self._pickHandler = pickHandler
	self._pickHandlerObj = pickHandlerObj
	self._showMsgBoxFunc = showMsgBoxFunc
	self._showMsgBoxFuncObj = showMsgBoxFuncObj

	CustomPickChoiceListModel.instance:initData(bePickChoiceHeroIdList, maxSelectCount)
	ViewMgr.instance:openView(ViewName.CustomPickChoiceView, viewParam)
end

function CustomPickChoiceController:openNewBiePickChoiceView(bePickChoiceHeroIdList, pickHandler, pickHandlerObj, viewParam, showMsgBoxFunc, showMsgBoxFuncObj, maxSelectCount)
	self._pickHandler = pickHandler
	self._pickHandlerObj = pickHandlerObj
	self._showMsgBoxFunc = showMsgBoxFunc
	self._showMsgBoxFuncObj = showMsgBoxFuncObj

	CustomPickChoiceListModel.instance:initData(bePickChoiceHeroIdList, maxSelectCount)
	ViewMgr.instance:openView(ViewName.NewbieCustomPickView, viewParam)
end

function CustomPickChoiceController:onOpenView()
	self:dispatchEvent(CustomPickChoiceEvent.onCustomPickListChanged)
end

function CustomPickChoiceController:setSelect(heroId)
	local isSelected = CustomPickChoiceListModel.instance:isHeroIdSelected(heroId)
	local selectCount = CustomPickChoiceListModel.instance:getSelectCount()
	local maxSelectCount = CustomPickChoiceListModel.instance:getMaxSelectCount()

	if not isSelected and maxSelectCount <= selectCount then
		if maxSelectCount > 1 then
			GameFacade.showToast(ToastEnum.CustomPickPleaseCancel)

			return
		else
			CustomPickChoiceListModel.instance:clearAllSelect()
		end
	end

	CustomPickChoiceListModel.instance:setSelectId(heroId)
	self:dispatchEvent(CustomPickChoiceEvent.onCustomPickListChanged)
end

function CustomPickChoiceController:tryChoice(viewParam)
	local maxSelectCount = CustomPickChoiceListModel.instance:getMaxSelectCount()
	local selectCount = CustomPickChoiceListModel.instance:getSelectCount()

	if not selectCount or maxSelectCount < selectCount then
		return false
	end

	if selectCount < maxSelectCount then
		local toastId

		if viewParam and viewParam.id and CustomPickChoiceEnum.SelectHeroToastEnum[viewParam.id] then
			toastId = CustomPickChoiceEnum.SelectHeroToastEnum[viewParam.id]
		end

		if toastId == nil then
			toastId = ToastEnum.CustomPickMoreSelect
		end

		GameFacade.showToast(toastId)

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
		local selectList = CustomPickChoiceListModel.instance:getSelectIds()

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

		local msgBoxId

		if hasHero then
			if viewParam and viewParam.id and CustomPickChoiceEnum.SelectHasHeroMsgBoxIdEnum[viewParam.id] then
				msgBoxId = CustomPickChoiceEnum.SelectHasHeroMsgBoxIdEnum[viewParam.id]
			end

			if msgBoxId == nil then
				msgBoxId = MessageBoxIdDefine.CustomPickChoiceHasHero
			end
		else
			msgBoxId = MessageBoxIdDefine.CustomPickChoiceConfirm
		end

		GameFacade.showMessageBox(msgBoxId, MsgBoxEnum.BoxType.Yes_No, self.realChoice, nil, nil, self, nil, nil, heroNames)
	end
end

function CustomPickChoiceController:realChoice()
	if not self._pickHandler then
		return
	end

	local selectList = CustomPickChoiceListModel.instance:getSelectIds()

	self._pickHandler(self._pickHandlerObj, self._tmpViewParam, selectList)

	self._tmpViewParam = nil
end

function CustomPickChoiceController:onCloseView()
	return
end

CustomPickChoiceController.instance = CustomPickChoiceController.New()

return CustomPickChoiceController
