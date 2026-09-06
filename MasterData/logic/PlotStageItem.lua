-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/PlotStageItem.lua

module("logic.extensions.plotcopy.view.PlotStageItem", package.seeall)

local PlotStageItem = class("PlotStageItem")
local LuaComponentContainer = Framework.LuaComponentContainer

PlotStageItem.arrowEffectPath = "fx_ui_zhangjiejiemian/fx_ui_zhangjiejiemian_01.prefab"

function PlotStageItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, PlotStageItem)

	component = component or LuaComponentContainer.Add(go, PlotStageItem)

	return component
end

function PlotStageItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._node = goutil.findChild(go, "node"):GetComponent(goutil.Type_RectTransform)
	self._bgGos = {}
	self._imgBgs = {}
	self._txtNames = {}
	self._imgNews = {}
	self._imgFinishs = {}

	for i = 1, 2 do
		self._bgGos[i] = goutil.findChild(go, string.format("node/bg%d", i))
		self._imgBgs[i] = goutil.findChild(self._bgGos[i], "bg"):GetComponent(goutil.Type_UIImage)
		self._txtNames[i] = goutil.findChild(self._bgGos[i], "txtName"):GetComponent(goutil.Type_UIText)
		self._imgNews[i] = goutil.findChild(self._bgGos[i], "imgNew")
		self._imgFinishs[i] = goutil.findChild(self._bgGos[i], "imgFinish")
	end

	self._imgLocked = goutil.findChild(go, "node/imgLocked")
	self._lockGo1 = goutil.findChild(go, "node/imgLocked/lock1")
	self._lockGo2 = goutil.findChild(go, "node/imgLocked/lock2")
	self._btnClick = GameUtil.asBtn(self._node)
	self._effectGo = goutil.findChild(go, "node/effect")
	self._arrowEffectGo = goutil.findChild(go, "node/effect/arrowEffect")
	self._circleEffectGo = goutil.findChild(go, "node/effect/circleEffect")
	self._petChallengeRectTrans = goutil.findChildRectTransformComponent(go, "node/btnPetChallenge")
	self._btnPetChallenge = Framework.ButtonAdapter.GetFrom(go, "node/btnPetChallenge")
	self._petChallengeIcon = goutil.findChild(go, "node/btnPetChallenge/icon")
	self._lockPetChallenge = goutil.findChild(go, "node/btnPetChallenge/lockPetChallenge")
	self._keyPetChallenge = goutil.findChild(go, "node/btnPetChallenge/keyPetChallenge")
	self._rareGo = goutil.findChild(go, "node/btnPetChallenge/rare")
	self._imgQuality = goutil.findChild(go, "node/btnPetChallenge/imgQuality"):GetComponent("UIImageSpriteChange")
	self._roleGo = goutil.findChild(go, "node/bg1/role")
end

function PlotStageItem:init(index, data, view)
	self._index = index
	self._data = data
	self._view = view

	self._btnClick:AddClickListener(self._onBtnClick, self)
	self._btnPetChallenge:AddClickListener(self._onPetChallengeClick, self)

	self._showType = 1
	self._showType = data.cfg.purePlot and 2 or 1

	for i = 1, 2 do
		if i == self._showType then
			self._bgGos[i]:SetActive(true)
		else
			self._bgGos[i]:SetActive(false)
		end
	end

	self._txtNames[self._showType].text = string.match(data.cfg.stageName, "(%d+-%d+)")

	if data.isLock then
		local val = 0.5019607843137255

		Game.ImageUtil.SetColorRGBA(self._imgBgs[self._showType], val, val, val, 1)
	else
		Game.ImageUtil.SetColorRGBA(self._imgBgs[self._showType], 1, 1, 1, 1)
	end

	self._imgLocked:SetActive(data.isLock)
	self._lockGo1:SetActive(data.isLock and self._showType == 1)
	self._lockGo2:SetActive(data.isLock and self._showType == 2)

	local x, y = self:_getNodePos(index)

	Framework.TransformUtil.SetAnchoredPos(self._node, 0, y)

	if data.isHavePerfect then
		self._imgFinishs[self._showType]:SetActive(data.isPerfect)

		local isPurePlot = data.cfg.purePlot

		if isPurePlot then
			self._imgFinishs[self._showType]:SetActive(false)
		end
	else
		self._imgFinishs[self._showType]:SetActive(false)
	end

	self:_setIsNewStageSymbol()
	goutil.setActive(self._btnPetChallenge.gameObject, false)
	self:_showRoleModel(self._data.cfg.stageCardRaceId)
end

function PlotStageItem:_setIsNewStageSymbol()
	local name = RoleModel.instance:getUserId() .. CopyConst.isNewStage .. self._data.cfg.chapterId .. self._data.cfg.stageId
	local nameValue = UnityEngine.PlayerPrefs.GetInt(name)
	local isNew = false
	local isPass = PlotCopyModel.instance:isStagePassed(self._data.cfg.chapterId, self._data.cfg.stageId)

	if self._data.openStageNum == self._index and not self._data.isLock then
		isNew = nameValue == 0

		self._imgNews[self._showType]:SetActive(isNew and not isPass)
	else
		self._imgNews[self._showType]:SetActive(false)
	end

	self._effectGo:SetActive(isNew and not isPass)
	self:_updateRewardEffect(isNew and not isPass)
end

function PlotStageItem:_getNodePos(index)
	local nodePoses = {
		{
			52.6,
			0
		},
		{
			12.2,
			-94
		},
		{
			-2.9,
			7.5
		},
		{
			37.1,
			83.4
		},
		{
			61.7,
			-86.7
		},
		{
			-12.5,
			72.9
		}
	}
	local num = index % 6

	num = num == 0 and 6 or num

	return unpack(nodePoses[num])
end

function PlotStageItem:_getLineEulerZ(index)
	local lineEulerZs = {
		-47.1,
		28.3,
		17.6,
		-36.4,
		48.3,
		1.68
	}
	local num = index % 6

	num = num == 0 and 6 or num

	return lineEulerZs[num]
end

function PlotStageItem:_getLineWidth(index)
	local widths = {
		247,
		225,
		264,
		295,
		216,
		284.5
	}
	local num = index % 6

	num = num == 0 and 6 or num

	return widths[num]
end

function PlotStageItem:reset()
	self._data = nil
	self._view = nil

	self._btnClick:RemoveClickListener()
	self._btnPetChallenge:RemoveClickListener()
	GlobalDispatcher:removeListener(GlobalNotify.EndStory, self._onStoryEnded, self)
	self:_updateRewardEffect(false)
	self:_resetPetChallengeContent()
	self:_resetRoleModel()
end

function PlotStageItem:_onBtnClick()
	if self._data.isLock then
		PlotCopyModel.instance:showUnLockTip(self._data.unlockState, self._data.cfg)
	else
		local isPurePlot = self._data.cfg.purePlot

		if isPurePlot then
			GlobalDispatcher:addListener(GlobalNotify.EndStory, self._onStoryEnded, self)
			GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._data.cfg.pureAnimId, StoryModel.StoryType.PlotCopy)
		else
			local chapterId = self._data.cfg.chapterId
			local stageId = self._data.cfg.stageId

			PlotCopyController.instance:openStageView(chapterId, stageId)
		end
	end
end

function PlotStageItem:_onStoryEnded(storyId)
	if self._data and self._data.cfg and self._data.cfg.pureAnimId == storyId then
		local cfg = self._data.cfg

		PlotCopyController.instance:sendChallengeReq(cfg.chapterId, cfg.stageId)
	end
end

function PlotStageItem:_updateRewardEffect(isShow)
	self:_removeEffect()

	if isShow then
		local scale = 1
		local parentGo

		self._arrowEffect = UIEffectManager.instance:playEffect(self._data.view, PlotStageItem.arrowEffectPath, self._arrowEffectGo.transform, 0, 0, true, false, nil, function(self, uiEffect)
			if self._data and self._data.view and self._data.view._clipRectTrans then
				self:_onEffectLoaded(uiEffect, self._data.view._clipRectTrans)
			end
		end, self)

		self._arrowEffect:setParent(self._arrowEffectGo.transform)
		self._arrowEffect:setScale(scale)
	end
end

function PlotStageItem:_removeEffect()
	if self._arrowEffect then
		UIEffectManager.instance:stopEffect(self._arrowEffect)

		self._arrowEffect = nil
	end
end

function PlotStageItem:_onEffectLoaded(uiEffect, clipRectTrans)
	if uiEffect.effGo then
		uiEffect.effGo.transform.localPosition = Vector3.New(0, 0, 0)
	end

	uiEffect:setClipping(clipRectTrans)
end

function PlotStageItem:_setPetChallengeContent()
	local challengeId = self._data.cfg.challengeId

	MaterialMgr.resetAll(self._rareGo)

	if challengeId <= 0 then
		goutil.setActive(self._btnPetChallenge.gameObject, false)
	else
		goutil.setActive(self._btnPetChallenge.gameObject, true)

		local challengeCfg = LegendConfig.instance:getLegendChallengeCfg(challengeId)

		if challengeCfg then
			if not challengeCfg.raceId then
				local raceId = 0
				local petCfg = CharacterConfig.instance:getPetCo(raceId)

				if petCfg then
					local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCfg.faceIds))

					uGuiUtil.setSpriteToImage(self._petChallengeIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
				end

				MaterialMgr.setCell(MatType.Rare, raceId, self._rareGo)
				self._imgQuality:SetState(self:_getRare(raceId))
			end
		end
	end

	local x = 108

	self._petChallengeRectTrans.anchoredPosition = Vector2.New(x, 90)

	local isPass = PlotCopyModel.instance:isStagePassed(self._data.cfg.chapterId, self._data.cfg.stageId)

	goutil.setActive(self._lockPetChallenge, not isPass)
	goutil.setActive(self._keyPetChallenge, isPass)
end

function PlotStageItem:_resetPetChallengeContent()
	local img = Framework.ImageBigBG.Get(self._petChallengeIcon)

	img:ClearImage()
	MaterialMgr.resetAll(self._rareGo)
end

function PlotStageItem:_onPetChallengeClick()
	if self._data.cfg.challengeId > 0 then
		local isUnlock = PlotCopyModel.instance:isStagePassed(self._data.cfg.chapterId, self._data.cfg.stageId)

		if not isUnlock then
			local challengeCfg = LegendConfig.instance:getLegendChallengeCfg(self._data.cfg.challengeId)

			if challengeCfg then
				local cfgOpen = FuncOpenConfig.instance:getFunctionOpenById(challengeCfg.unlockId)

				if cfgOpen then
					FloatWordMgr.instance:show(cfgOpen.description)
				else
					FloatWordMgr.instance:show("请先通过本关卡")
				end
			end
		else
			self:_jumpToView()
		end
	end
end

function PlotStageItem:_jumpToView()
	local challengeId = self._data.cfg.challengeId

	GlobalDispatcher:dispatch(GlobalNotify.CopyCloseChapterView)

	local param = {
		challengeId = challengeId
	}

	UIStateManager.instance:push(ViewName.PetChallengeView, param)
end

function PlotStageItem:_getRare(raceId)
	local petCfg = CharacterConfig.instance:getPetCo(raceId)

	if petCfg == nil then
		return 0
	end

	local rare = CharacterConfig.instance:getRareByAwakenLv(petCfg.initAwakenLv, raceId)

	return rare - 1
end

function PlotStageItem:_showRoleModel(raceId)
	local cfg = CharacterConfig.instance:getPetCo(raceId)

	if not cfg then
		return
	end

	local offset = CharactorFacade.instance:getFormationModelUIPosAndScale(checknumber(cfg.faceIds))
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self:_resetRoleModel()

	local isAuto = false
	local callback

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, cfg.faceIds, self._roleGo, scale, callback, isAuto, x, y)

	local chapterId = self._data.cfg.chapterId

	PlotCopyController.instance:cachePlotChapterviewRes(chapterId, self.loader.loader.path)
end

function PlotStageItem:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

return PlotStageItem
