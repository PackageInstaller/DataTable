-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/controller/MainUIController.lua

module("logic.extensions.mainui.controller.MainUIController", package.seeall)

local MainUIController = class("MainUIController", BaseController)

function MainUIController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.SelectPlayerPet, self.onPetClick, self)
	self:onReset()
end

function MainUIController:onReset()
	self.hideHudIdMap = {}
	self.taskOk = false
	self.bottomLeftViewPool = {}
	self.bottomLeftShowingList = {}
	self.bottomLeftGo = nil
	self.parentPresentor = nil

	if self.tween then
		self.tween:Kill(false)
	end

	self.tween = nil
	self.btnsList = nil
end

function MainUIController:setHudVisible(id, visible)
	self.hideHudIdMap[id] = visible
end

function MainUIController:getHudVisible(id)
	return self.hideHudIdMap[id]
end

function MainUIController:setBtnsList(btns)
	self.btnsList = btns

	GlobalDispatcher:dispatch(GlobalNotify.MainActBtnUpdate)
end

function MainUIController:setExpandBtnsList(btns)
	self.btnsExpandList = btns

	GlobalDispatcher:dispatch(GlobalNotify.MainActBtnUpdate)
end

function MainUIController:getBtnHasOk(id)
	if self.btnsList and self.taskOk then
		if self.btnsList[id] then
			if not self.btnsList[id].go then
				local go

				if go then
					return go.activeInHierarchy
				end

				if self.btnsExpandList then
					if self.btnsExpandList[id] then
						if not self.btnsExpandList[id].go then
							local go

							if go then
								return go.activeInHierarchy
							end
						end
					end
				end

				return FuncOpenModel.instance:getFuncIsOpenFinished(id)
			end
		end
	end

	return false
end

function MainUIController:playRandomMainPetChat(unitPet)
	local currChapterId = TaskFacade.instance:getCurrMainChapterId()
	local wordsCfg = CharacterConfig.instance:getRandomPetFollowWords(currChapterId)

	if not wordsCfg then
		if unitPet.talkhud then
			unitPet.talkhud:showAutoChatWord("不要戳我")
		end

		return
	end

	unitPet.talkhud:showAutoChatWord(wordsCfg.text)
end

function MainUIController:onPetClick(unitPet)
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()
	local mainPlayerPet = SceneMainPlayer.instance:getMainPlayerPet()

	if mainPlayerPet == unitPet then
		self:playRandomMainPetChat(unitPet)

		return
	end

	local owner = unitPet:getOwner()

	if owner ~= nil then
		if owner == mainPlayer or owner == mainPlayerPet then
			print(">>>>>>> click pet", unitPet.talkhud)
			SurveyController.instance:reportBehavior(SurveyBehaviorID.CLICK_SCENE_PET)

			local word = PigraiseModel.instance:getCurPigDialogue()

			if word then
				unitPet.talkhud:showAutoChatWord(word)
			end
		elseif unitPet.talkhud then
			unitPet.talkhud:showAutoChatWord("不要戳我")
		end
	end
end

function MainUIController:showGlodBar(parentGo, parentPresentor, params, defaultDiamondAdd)
	params = params or MainuiModel.instance:getTopBarParams()

	MainuiModel.instance:setTopBarParams(params, defaultDiamondAdd)

	local viewMgr = ViewMgr.instance

	if viewMgr:isOpen(ViewName.MainTopGoldView) then
		viewMgr:close(ViewName.MainTopGoldView)
	end

	viewMgr:openAt(parentGo, ViewName.MainTopGoldView, parentPresentor)
	GlobalDispatcher:dispatch(GlobalNotify.MainTopGoldBarUpdate)
end

function MainUIController:showSkinGlodBar(parentGo, parentPresentor, params, defaultDiamondAdd)
	params = params or MainuiModel.instance:getTopBarParams()

	MainuiModel.instance:setTopBarParams(params, defaultDiamondAdd)

	local viewMgr = ViewMgr.instance

	if viewMgr:isOpen(ViewName.MainTopGoldSkinView) then
		viewMgr:close(ViewName.MainTopGoldSkinView)
	end

	viewMgr:openAt(parentGo, ViewName.MainTopGoldSkinView, parentPresentor)
	GlobalDispatcher:dispatch(GlobalNotify.MainTopGoldBarUpdate)
end

function MainUIController:showImpressionStickerNumBubble(parentGo, parentPresentor, raceId)
	if raceId == nil then
		printInfo("没有raceId参数")

		return
	end

	local viewMgr = ViewMgr.instance

	if viewMgr:isOpen(ViewName.ImpressionStickerPopBubbleView) then
		viewMgr:close(ViewName.ImpressionStickerPopBubbleView)
	end

	local defineCfg = HandbookConfig.instance:getPetRankConfByRaceId(raceId)
	local rankId = defineCfg.id
	local hasImpressionStickerCfg = HandbookConfig.instance:getHasImpressionStickerCfg(rankId)

	if hasImpressionStickerCfg then
		local rankType = hasImpressionStickerCfg.rankType

		viewMgr:openAt(parentGo, ViewName.ImpressionStickerPopBubbleView, parentPresentor, raceId, rankId, rankType)
	end
end

function MainUIController:openBottomLeftView(viewName, ...)
	local obj = self.bottomLeftViewPool[viewName]
	local params = {
		...
	}

	if obj == nil then
		obj = {}
		obj.needClose = true
		obj.params = params
		self.bottomLeftViewPool[viewName] = obj
	else
		for i, v in ipairs((not obj.params or nil) and {}) do
			if params[i] ~= v then
				obj.needClose = true

				break
			end
		end

		obj.params = params
	end

	self:realShowBLView()
end

function MainUIController:closeBottomLeftView(viewName)
	self.bottomLeftViewPool[viewName] = nil

	ViewMgr.instance:close(viewName)
	self:realShowBLView()
end

function MainUIController:realShowBLView()
	if self.bottomLeftGo ~= nil then
		local viewName, obj

		for k, v in pairs(self.bottomLeftViewPool) do
			viewName = k
			obj = v

			if k ~= nil then
				local params = obj.params
				local viewMgr = ViewMgr.instance

				if obj.needClose then
					obj.needClose = false

					if viewMgr:isOpen(k) then
						viewMgr:close(k)
					end
				end

				viewMgr:openAt(self.bottomLeftGo, k, self.parentPresentor, GameUtil.unpack10(params))

				self.bottomLeftShowingList[k] = true
			end
		end
	end
end

function MainUIController:setMainBottomLeftGo(go, presentor)
	if self.tween then
		self.tween:Kill(false)

		self.tween = nil
	end

	self.bottomLeftGo = go
	self.parentPresentor = presentor

	if go ~= nil then
		self:realShowBLView()
	else
		for viewName, v in pairs(self.bottomLeftShowingList) do
			ViewMgr.instance:close(viewName)
		end

		self.bottomLeftShowingList = {}
	end
end

function MainUIController:openMainBtnExpandView(pos, funcId, ids)
	if pos == nil then
		return
	end

	local params = {
		localPos = pos,
		fatFuncId = checknumber(funcId),
		sonFuncIds = ids
	}

	GlobalDispatcher:dispatch(GlobalNotify.MainBtnExpandViewOpen, params)

	return true
end

MainUIController.instance = MainUIController.New()

return MainUIController
