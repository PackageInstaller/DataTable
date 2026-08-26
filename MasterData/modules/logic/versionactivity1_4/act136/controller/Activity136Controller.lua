-- chunkname: @modules/logic/versionactivity1_4/act136/controller/Activity136Controller.lua

module("modules.logic.versionactivity1_4.act136.controller.Activity136Controller", package.seeall)

local Activity136Controller = class("Activity136Controller", BaseController)

function Activity136Controller:onInit()
	return
end

function Activity136Controller:addConstEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivityState, self)
end

function Activity136Controller:reInit()
	TaskDispatcher.cancelTask(self._delayGetInfo, self)
end

function Activity136Controller:_onRefreshActivityState()
	if ActivityModel.instance:isActOnLine(self:actId()) then
		TaskDispatcher.cancelTask(self._delayGetInfo, self)
		TaskDispatcher.runDelay(self._delayGetInfo, self, 0.2)
	end
end

function Activity136Controller:_delayGetInfo()
	Activity136Rpc.instance:sendGet136InfoRequest(self:actId())
end

function Activity136Controller:confirmReceiveCharacterCallback()
	ViewMgr.instance:closeView(ViewName.Activity136ChoiceView)
	ViewMgr.instance:closeView(ViewName.LifeCirclePickChoice)
end

function Activity136Controller:openActivity136View(viewParam)
	local isInOpen = Activity136Model.instance:isActivity136InOpen(true)

	if isInOpen then
		ViewMgr.instance:openView(ViewName.Activity136View, viewParam)
	end
end

function Activity136Controller:openActivity136ChoiceView()
	local isInOpen = Activity136Model.instance:isActivity136InOpen(true)

	if not isInOpen then
		return
	end

	local hasReceive = Activity136Model.instance:hasReceivedCharacter()

	if hasReceive then
		GameFacade.showToast(ToastEnum.Activity136AlreadyReceive)

		return
	end

	local actId = self:actId()
	local heroIdList = Activity136Config.instance:getSelfSelectCharacterIdList(actId)
	local isCustomSelect = true
	local viewParam = {
		heroIdList = heroIdList,
		title = luaLang("p_activity136choiceview_txt_title"),
		confirmDesc = luaLang("confirm"),
		isCustomSelect = isCustomSelect,
		callback = function(viewObj)
			local targetHeroId = isCustomSelect and viewObj:selectedHeroId() or 0

			if isCustomSelect then
				if targetHeroId == 0 then
					GameFacade.showToast(ToastEnum.Activity136NotSelect)

					return
				end

				Activity136Controller.instance:receiveCharacter(targetHeroId)
			else
				assert(false, "not support random select")
			end
		end
	}

	ViewMgr.instance:openView(ViewName.LifeCirclePickChoice, viewParam)
end

function Activity136Controller:receiveCharacter(selectCharacterId)
	local isInOpen = Activity136Model.instance:isActivity136InOpen(true)

	if not isInOpen then
		return
	end

	if not selectCharacterId then
		GameFacade.showToast(ToastEnum.Activity136NotSelect)

		return
	end

	local hasReceive = Activity136Model.instance:hasReceivedCharacter()

	if hasReceive then
		GameFacade.showToast(ToastEnum.Activity136AlreadyReceive)

		return
	end

	local heroMo = HeroModel.instance:getByHeroId(selectCharacterId)
	local heroConfig = HeroConfig.instance:getHeroCO(selectCharacterId)
	local msgId = MessageBoxIdDefine.Activity136SelectCharacter

	if heroConfig then
		if not heroConfig.name then
			local heroName = ""
			local duplicateItemName = ""
			local duplicateItemCount = ""

			if heroMo and heroConfig then
				local itemParams = {}
				local isMaxExSkill = HeroModel.instance:isMaxExSkill(selectCharacterId, true)

				if not isMaxExSkill then
					local duplicateItem1List = GameUtil.splitString2(heroConfig.duplicateItem, true)

					itemParams = duplicateItem1List and duplicateItem1List[1] or itemParams
					msgId = MessageBoxIdDefine.Activity136SelectCharacterRepeat
				else
					itemParams = string.splitToNumber(heroConfig.duplicateItem2, "#") or itemParams
					duplicateItemCount = itemParams[3] or ""
					msgId = MessageBoxIdDefine.Activity136SelectCharacterRepeat2
				end

				local itemType = itemParams[1]
				local itemId = itemParams[2]

				if itemType and itemId then
					local itemConfig, _ = ItemModel.instance:getItemConfigAndIcon(itemParams[1], itemParams[2])

					duplicateItemName = itemConfig and itemConfig.name or ""
				end
			end

			GameFacade.showMessageBox(msgId, MsgBoxEnum.BoxType.Yes_No, function()
				self:_confirmSelect(selectCharacterId)
			end, nil, nil, self, nil, nil, heroName, duplicateItemName, duplicateItemCount)
		end
	end
end

function Activity136Controller:_confirmSelect(selectCharacterId)
	Activity136Rpc.instance:sendAct136SelectRequest(self:actId(), selectCharacterId)
end

function Activity136Controller:actId()
	return Activity136Model.instance:getCurActivity136Id()
end

Activity136Controller.instance = Activity136Controller.New()

return Activity136Controller
