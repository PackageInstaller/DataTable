-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/makesnowman/view/MakeSnowmanSliderCell.lua

module("logic.extensions.makesnowman.view.MakeSnowmanSliderCell", package.seeall)

local MakeSnowmanSliderCell = class("MakeSnowmanSliderCell")

function MakeSnowmanSliderCell:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self.mainGO = go
	self._txtScore = goutil.findChildTextComponent(go, "txtScore")
	self._item = goutil.findChild(go, "snowmanComplete/item")
	self._canGet = goutil.findChild(go, "snowmanComplete/canGet")
	self._geted = goutil.findChild(go, "snowmanComplete/geted")
	self._complete = goutil.findChild(go, "snowmanComplete")
	self._snowman = goutil.findChild(go, "snowman")
	self._snowmanComplete = goutil.findChild(go, "snowmanComplete")
	self._prizeNotGet = goutil.findChild(go, "item")
	self._btnItem = GameUtil.asBtn(goutil.findChild(go, "btnCell"))
	self._btnStart = GameUtil.asBtn(goutil.findChild(go, "btnStart"))
	self._snowmanChange = goutil.findChildComponent(go, "snowman", "UIImageSpriteChange")
	self._unit = goutil.findChild(go, "snowman/pos_1")
	self._units = ItemGroup.New(self._snowman, self._unit)
end

function MakeSnowmanSliderCell:getGo()
	return self.mainGO
end

function MakeSnowmanSliderCell:init(data, view, rectTrans, callbackParams)
	self._view = view
	self._rectTrans = rectTrans
	self._data = data
	self._callbackParams = callbackParams
	self._txtScore.text = self._callbackParams.parseGetProgress and self._callbackParams.parseGetProgress(data) or self._callbackParams.needScore
	self._prize = self._callbackParams.prize and self._callbackParams.prize or self._data.prize

	self:_doInit()
	self:_afterInit()
end

function MakeSnowmanSliderCell:_doInit()
	local matType, id, matNum = MaterialMgr.getMatParams(self._prize)

	MaterialMgr.resetAll(self._item)

	self._itemProxy = MaterialMgr.setCellByCfg(self._prize, self._item)

	self._itemProxy.binder:setAutoTips(true)
	self._itemProxy.binder:setBgActive(not self._callbackParams.bHideCellBg)

	local function loadHandle(finishHandlerTarget, eff)
		if goutil.isNil(self._btnStart.gameObject) then
			UIEffectManager.instance:stopEffect(eff)

			return
		end

		GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self._btnStart.gameObject) + 1)
		eff:setParent(self._btnStart.gameObject.transform)

		local parentSVs = eff.effGo:GetComponentsInParent(typeof(UnityEngine.UI.ScrollRect), true)
		local parentSV

		if not goutil.isNil(parentSVs) and parentSVs.Length >= 2 then
			local parentScrollOfParent = parentSVs[1]
			local transform = parentScrollOfParent.gameObject.transform:GetChild(0)

			if transform and transform.name == "doubleScrollViewport" then
				eff:setClipping(transform:GetComponent(goutil.Type_RectTransform))
			end
		else
			if not goutil.isNil(parentSVs) and parentSVs.Length > 0 then
				parentSV = parentSVs[0]
			end

			if parentSV then
				if not goutil.isNil(parentSV.viewport) then
					eff:setScrollRectClipping(parentSV)
				elseif not goutil.isNil(parentSV.content) then
					eff:setClipping(parentSV:GetComponent(goutil.Type_RectTransform))
				end
			else
				local rect = GlobalModel.instance.uiRoot.gameObject:GetComponent(goutil.Type_RectTransform)

				eff:setClipping(rect)
			end
		end

		local views = ViewMgr.instance._views

		for k, v in pairs(views) do
			if ViewMgr.instance:isOpen(k) and not goutil.isNil(v.mainGO) and eff.effGo.transform:IsChildOf(v.mainGO.transform) then
				eff.view = v._views[1]

				break
			end
		end

		if not eff.view then
			eff:setLayer(SceneLayer.Invisible_Value)
		else
			local isTop = GlobalModel.instance:isTopView(eff.view._viewPresentor)

			eff:setTop(isTop)
		end
	end

	self._btnEffect = UIEffectManager.instance:playEffectBrief(self._view, "20221223/xuerenduiduile/fx_ui_xuerenduiduile_xrfg.prefab", nil, true, loadHandle)

	self._btnEffect:setParent(self._btnStart.gameObject.transform)
	self._btnEffect:setLocalPos(2, -20.7, 0)
	self._btnEffect:setScale(0.45, 0.45, 0.45)

	self._btnEffect.hideEffWhileNotOnTop = true
	self._snowmanCfg = MakeSnowmanConfig.instance:getSnowmanCfg(self._data.snowmanId)
	self._posChange = {}

	self._units:updateWithMoArray(self._snowmanCfg, self._updateSnowmanUnitCell, self)
	self._btnItem:AddClickListener(self._onClickItem, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
end

function MakeSnowmanSliderCell:_afterInit()
	if self._callbackParams and self._callbackParams.initCellFunc then
		self._callbackParams.initCellFunc(self._item, self._data, self._view)
	end

	if MakeSnowmanModel.instance:getCurBuildSnowman() == self._data.prizeId then
		GlobalDispatcher:dispatch(GlobalNotify.MakeSnowmanShowUnit, self._snowman, self._data.prizeId)
	end

	self:update()
end

function MakeSnowmanSliderCell:_onClickItem()
	local rewardCfg = self._data
	local matType, id, matNum = MaterialMgr.getMatParams(self._prize)

	if self._callbackParams and self._callbackParams.isPlayerRewardCanGet(rewardCfg) then
		-- block empty
	elseif not goutil.isNil(self._item) then
		CommonTipsMgr.instance:openMaterialTips(self._item, matType, id, 0)
	end
end

function MakeSnowmanSliderCell:_onClickStart()
	if MakeSnowmanModel.instance:getCurBuildSnowman() == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.MakeSnowmanShowUnit, self._snowman, self._data.prizeId)
	end
end

function MakeSnowmanSliderCell:update()
	self._units:updateWithMoArray(self._snowmanCfg, self._updateSnowmanUnitCell, self)

	local rewardCfg = self._data
	local isGeted = self._callbackParams.isPlayerRewardGeted(rewardCfg)
	local isCanGet = self._callbackParams.isPlayerRewardCanGet(rewardCfg)

	if not isCanGet and not isGeted then
		self._snowmanChange:ChangeSprite("board_duixueren_09")
	else
		self._snowmanChange:ChangeSprite(self._snowmanCfg[1].completeRes)
	end

	local units = MakeSnowmanModel.instance:getUnits()

	if MakeSnowmanModel.instance:getCurBuildSnowman() == rewardCfg.prizeId then
		self._snowmanChange:ChangeSprite("board_duixueren_10")

		for j, snowmanCfg in ipairs(self._snowmanCfg) do
			GameUtil.SetActive(self._posChange[snowmanCfg.posId], true)
		end
	elseif isCanGet == true then
		self._snowmanChange:ChangeSprite("board_duixueren_10")

		for i, snowmanCfg in ipairs(self._snowmanCfg) do
			GameUtil.SetActive(self._posChange[snowmanCfg.posId], false)
		end
	else
		for i, snowmanCfg in ipairs(self._snowmanCfg) do
			GameUtil.SetActive(self._posChange[snowmanCfg.posId], false)
		end
	end

	self._itemProxy.binder:setGray(isGeted)
	GameUtil.SetActive(self._btnStart, isCanGet and MakeSnowmanModel.instance:getCurBuildSnowman() ~= rewardCfg.prizeId)
	GameUtil.SetActive(self._btnItem, false and not isCanGet)
	GameUtil.SetActive(self._snowman, true)
	GameUtil.SetActive(self._snowmanComplete, not isCanGet)
	GameUtil.SetActive(self._prizeNotGet, false)
	GameUtil.SetActive(self._canGet, isCanGet)
	GameUtil.SetActive(self._geted, isGeted)

	if isCanGet then
		self:_playEffect()
	else
		self:_clearEffect()
	end

	if self._callbackParams and self._callbackParams.updateCellFunc then
		self._callbackParams.updateCellFunc(self._item, self._data, self._view)
	end

	return isGeted, isCanGet
end

function MakeSnowmanSliderCell:clear()
	MaterialMgr.resetAll(self._item)
	GameUtil.rmClickHandler(self._btnItem)
	GameUtil.rmClickHandler(self._btnStart)
	UIEffectManager.instance:stopEffect(self._btnEffect)

	self._itemProxy = nil

	self._units:dispose()
end

function MakeSnowmanSliderCell:_updateSnowmanUnitCell(cell, data, index)
	local go = cell.mainGO
	local container = go:GetComponent(typeof(UIDragContainer))
	local imgChange = goutil.findChildComponent(go, "snowPuzzle", "UIImageSpriteChange")

	go.name = "pos_" .. data.posId

	GameUtil.setAnchoredPos(go, data.posOffset[1], data.posOffset[2])
	GameUtil.setWidth(go, data.posOffset[3])
	GameUtil.setHeight(go, data.posOffset[4])
	imgChange:ChangeSprite(data.showRes)

	local units = MakeSnowmanModel.instance:getUnits()

	if units and units[data.posId] then
		container.filter = checknumber(MakeSnowmanModel.instance:getDragCellIndex()) == data.posId and 0 or 1

		GameUtil.SetActive(imgChange, false)
	else
		container.filter = 1

		GameUtil.SetActive(imgChange, true)
	end

	self._posChange[data.posId] = go
end

function MakeSnowmanSliderCell:getRewardState()
	local isGeted = self._callbackParams.isPlayerRewardGeted(self._data)
	local isCanGet = self._callbackParams.isPlayerRewardCanGet(self._data)

	return isGeted, isCanGet
end

function MakeSnowmanSliderCell:getNormalizedPos()
	return self._callbackParams.normalizedPos
end

function MakeSnowmanSliderCell:_playEffect()
	self:_clearEffect()

	if not self._callbackParams.effPath then
		local effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"
		local uiEffect = UIEffectManager.instance:playEffect(self._view, effPath, self._canGet.transform, 0, 0, true, false, nil, function(target, eff)
			if not goutil.isNil(self._rectTrans) then
				eff:setClipping(self._rectTrans)
			end
		end)

		uiEffect:setParent(self._canGet.transform)
		uiEffect:setLocalPos(0, 0, 0)
		uiEffect:setScale(1)

		self._uiEffect = uiEffect
	end
end

function MakeSnowmanSliderCell:_clearEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

return MakeSnowmanSliderCell
