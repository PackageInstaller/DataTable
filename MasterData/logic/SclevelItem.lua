-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scenariocopy/view/SclevelItem.lua

module("logic.extensions.scenariocopy.view.SclevelItem", package.seeall)

local SclevelItem = class("SclevelItem")
local LuaComponentContainer = Framework.LuaComponentContainer

function SclevelItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, SclevelItem)

	component = component or LuaComponentContainer.Add(go, SclevelItem)

	return component
end

function SclevelItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._node = goutil.findChild(go, "node"):GetComponent(goutil.Type_RectTransform)
	self._effectGo = goutil.findChild(go, "node/effect")
	self._btnMain = GameUtil.asBtn(goutil.findChild(go, "node/btnClick"))
	self._imgLocked = goutil.findChild(go, "node/imgLocked")
	self._txtMainName = goutil.findChild(go, "node/txtName"):GetComponent(goutil.Type_UIText)
	self._txtOrderNumber = goutil.findChild(go, "node/txtNum"):GetComponent(goutil.Type_UIText)
	self._mainIcon = goutil.findChild(go, "node/mainImg")
end

function SclevelItem:OnDestroy()
	GlobalDispatcher:removeListener(GlobalNotify.ScenariocopyRedPointUpdate, self._refreshLockAndRedPoint, self)
	self:_stopChallengingEffect()
	uGuiUtil.clearImage(self._mainIcon)
end

function SclevelItem:init(index, data, view)
	self._index = index
	self._data = data
	self._view = view

	self._btnMain:AddClickListener(self._onBtnClickMain, self)

	local x, y = self._data.mainCfg.pos[1], self._data.mainCfg.pos[2]

	Framework.TransformUtil.SetAnchoredPos(self._node, x, y)

	local mainStageCfg = ScenariocopyConfig.instance:getStageCfg(self._data.mainCfg.chapterId, 1)

	uGuiUtil.setSpriteToImage(self._mainIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getScenarioCopyUrl(self._data.mainCfg.icon))
	self:_refreshLockAndRedPoint()
	GlobalDispatcher:addListener(GlobalNotify.ScenariocopyRedPointUpdate, self._refreshLockAndRedPoint, self)
end

function SclevelItem:_stopChallengingEffect()
	if self._challengingEffect ~= nil then
		UIEffectManager.instance:stopEffect(self._challengingEffect)

		self._challengingEffect = nil
	end
end

function SclevelItem:_refreshLockAndRedPoint()
	local mainUnlockCondition = self._data.mainCfg.unlockCondition
	local isMainOpen = ScenariocopyModel.instance:getStagePass(mainUnlockCondition[2], mainUnlockCondition[3])

	self._imgLocked:SetActive(not isMainOpen)
	GameUtil.SetGray(self._mainIcon, not isMainOpen)
	self:_stopChallengingEffect()

	if isMainOpen and not ScenariocopyModel.instance:getStagePass(self._data.mainCfg.chapterId, 1) then
		self._challengingEffect = UIEffectManager.instance:playEffect(self._view, "fx_ui_fuben/fx_ui_fuben_jiaozhan.prefab", self._effectGo.transform, 0, 0, true, false, nil, function(self, uiEffect)
			if self._data and self._view and self._view._clipRectTrans then
				self:_onEffectLoaded(uiEffect, self._view._clipRectTrans)
			end

			uiEffect.hideEffWhileNotOnTop = true

			GoUtil.SetSortingOrder(uiEffect.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self._effectGo) + 1)
		end, self)

		self._challengingEffect:setParent(self._effectGo.transform)
		self._challengingEffect:setScale(0.8)
	end

	self._txtMainName.text = self._data.mainCfg.chapterName
	self._txtOrderNumber.text = self._data.mainCfg.orderNumber
end

function SclevelItem:reset()
	self._data = nil
	self._view = nil

	self:_stopChallengingEffect()
	self._btnMain:RemoveClickListener()
	self._btnYangtrial:RemoveClickListener()
	self._btnWatertrial:RemoveClickListener()
end

function SclevelItem:_onBtnClick()
	if self._data.isLock then
		PlotCopyModel.instance:showUnLockTip(self._data.unlockState, self._data.cfg)
	end
end

function SclevelItem:_onBtnClickMain()
	local mainUnlockCondition = self._data.mainCfg.unlockCondition
	local chapterId = mainUnlockCondition[2]
	local stageId = mainUnlockCondition[3]
	local isMainOpen = ScenariocopyModel.instance:getStagePass(chapterId, stageId)
	local stageCfg

	if chapterId ~= nil and stageId ~= nil then
		stageCfg = ScenariocopyConfig.instance:getStageCfg(chapterId, stageId)
	end

	local curStageCfg = ScenariocopyConfig.instance:getStageCfg(self._data.mainCfg.chapterId, 1)

	if isMainOpen then
		ScenariocopyModel.instance:setStageCfg(curStageCfg)
		ScenariocopyModel.instance:setChapterCfg(self._data.mainCfg)
		ScenariocopyModel.instance:setChapterId(self._data.mainCfg.chapterId)
		ScenariocopyModel.instance:setStageId(1)

		if curStageCfg.pureAnimId > 0 then
			ScenariocopyController.instance:enterMissionOrStory(curStageCfg)
		else
			UIStateManager.instance:open(ViewName.ScmainStageView, curStageCfg)
		end
	else
		local name1 = ScenariocopyController.instance:getStageName(nil, chapterId, stageId, true)
		local name2 = ScenariocopyController.instance:getStageName(nil, self._data.mainCfg.chapterId, 1, false)

		FloatWordMgr.instance:show(langPara("通关[%s]后，开启[%s]", name1, name2))
	end
end

return SclevelItem
