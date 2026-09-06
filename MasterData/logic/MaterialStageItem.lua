-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/MaterialStageItem.lua

module("logic.extensions.materialchallenge.view.MaterialStageItem", package.seeall)

local MaterialStageItem = class("MaterialStageItem")
local LuaComponentContainer = Framework.LuaComponentContainer

function MaterialStageItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, MaterialStageItem)

	component = component or LuaComponentContainer.Add(go, MaterialStageItem)

	return component
end

function MaterialStageItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._node = goutil.findChild(go, "node"):GetComponent(goutil.Type_RectTransform)
	self._line = goutil.findChild(go, "node/line"):GetComponent(goutil.Type_RectTransform)
	self._bgGos = goutil.findChild(go, string.format("node/bg1", i))
	self._imgBgs = goutil.findChild(self._bgGos, "bg"):GetComponent(goutil.Type_UIImage)
	self._txtNames = goutil.findChild(self._bgGos, "txtName"):GetComponent(goutil.Type_UIText)
	self._imgNews = goutil.findChild(self._bgGos, "imgNew")
	self._imgLocked = goutil.findChild(go, "node/imgLocked")
	self._btnClick = GameUtil.asBtn(self._node)
	self._effectGo = goutil.findChild(go, "node/effect")
	self._evaluateGo = goutil.findChild(go, "node/evaluate")
	self._txtEvaluate = goutil.findChild(go, "node/evaluate/txtEvaluate"):GetComponent(goutil.Type_UIText)
	self._evaluateSpriteChange = goutil.findChild(go, "node/evaluate"):GetComponent("UIImageSpriteChange")
end

function MaterialStageItem:init(index, data, view)
	self._index = index
	self._data = data
	self._view = view

	if index == 0 then
		self._node.gameObject:SetActive(false)

		return
	else
		self._node.gameObject:SetActive(true)
	end

	self._btnClick:AddClickListener(self._onBtnClick, self)
	self._bgGos:SetActive(true)

	self._txtNames.text = data.cfg.stageName

	if data.isLock then
		local val = 0.5019607843137255

		Game.ImageUtil.SetColorRGBA(self._imgBgs, val, val, val, 1)
	else
		Game.ImageUtil.SetColorRGBA(self._imgBgs, 1, 1, 1, 1)
	end

	self._imgLocked:SetActive(data.isLock)

	local x, y = self:_getNodePos(index)

	Framework.TransformUtil.SetAnchoredPos(self._node, x, y)
	self._line.gameObject:SetActive(not data.isLast)

	if not data.isLast then
		local x1, y1 = self:_getLinePos(index)

		Framework.TransformUtil.SetAnchoredPos(self._line, x1, y1)

		local z2 = self:_getLineEulerZ(index)

		Framework.TransformUtil.SetLocalRotation(self._line.transform, 0, 0, z2)

		local width = self:_getLineWidth(index)

		self._line.sizeDelta = Vector3.New(width, self._line.sizeDelta.y, self._line.sizeDelta.z)
	end

	local isPass = MaterialChallengeModel.instance:isStagePassed(self._data.cfg.chapterId, self._data.cfg.stageId)

	self:_setIsNewStageSymbol(isPass)
	self:_setEvaluate(isPass)
end

function MaterialStageItem:_setIsNewStageSymbol(isPass)
	local name = RoleModel.instance:getUserId() .. CopyConst.isNewResStage .. self._data.cfg.chapterId .. self._data.cfg.stageId
	local nameValue = UnityEngine.PlayerPrefs.GetInt(name)
	local isNew = false

	if self._data.openStageNum == self._index and not self._data.isLock then
		isNew = nameValue == 0

		self._imgNews:SetActive(isNew and not isPass)
	else
		self._imgNews:SetActive(false)
	end

	self._effectGo:SetActive(isNew and not isPass)
	self:_updateRewardEffect(isNew and not isPass)
end

function MaterialStageItem:_setEvaluate(isPass)
	self._evaluateGo:SetActive(isPass)

	local evaluateValue = self._data.evaluateValue

	self._txtEvaluate.text = evaluateValue

	self._evaluateSpriteChange:ChangeStateNow(self:_getIndex(evaluateValue))
end

function MaterialStageItem:_getIndex(evaluateValue)
	if evaluateValue == "S" then
		return 0
	elseif evaluateValue == "A" then
		return 1
	elseif evaluateValue == "B" then
		return 2
	elseif evaluateValue == "C" then
		return 3
	else
		return 4
	end
end

function MaterialStageItem:_getNodePos(index)
	local nodePoses = {
		{
			2.6,
			83.6
		},
		{
			-42.2,
			-94
		},
		{
			-52.9,
			7.5
		},
		{
			-27.1,
			83.4
		},
		{
			11.7,
			-86.7
		},
		{
			-62.5,
			72.9
		}
	}
	local num = index % 6

	num = num == 0 and 6 or num

	return unpack(nodePoses[num])
end

function MaterialStageItem:_getLinePos(index)
	local linePoses = {
		{
			85.1,
			-90.5
		},
		{
			99,
			52.9
		},
		{
			108.25,
			35.41
		},
		{
			119,
			-87.1
		},
		{
			70.7,
			78.7
		},
		{
			137.5,
			5.9
		}
	}
	local num = index % 6

	num = num == 0 and 6 or num

	return unpack(linePoses[num])
end

function MaterialStageItem:_getLineEulerZ(index)
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

function MaterialStageItem:_getLineWidth(index)
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

function MaterialStageItem:reset()
	self._data = nil
	self._view = nil

	self._btnClick:RemoveClickListener()
	self:_updateRewardEffect(false)
end

function MaterialStageItem:_onBtnClick()
	if self._data.isLock then
		local unlockId = self._data.cfg.unlockId
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(unlockId)
		local isOpen = FuncOpenModel.instance:getFuncIsOpen(unlockId)

		if cfg and not isOpen then
			FloatWordMgr.instance:show(cfg.description)
		else
			FloatWordMgr.instance:show("请先通过前一关卡")
		end
	else
		MaterialChallengeController.instance:openStageView(self._data.cfg.chapterId, self._data.cfg.stageId)
	end
end

function MaterialStageItem:_updateRewardEffect(isShow)
	if self._rewardEffect then
		UIEffectManager.instance:stopEffect(self._rewardEffect)

		self._rewardEffect = nil
	end

	if isShow then
		self._rewardEffect = UIEffectManager.instance:playEffect(self._data.view, "fx_ui_juqingfuben/fx_ui_juqingfuben01.prefab", self._effectGo.transform, 0, 0, true, false, nil, function(self, uiEffect)
			if self._data and self._data.view and self._data.view._clipRectTrans then
				self:_onEffectLoaded(uiEffect, self._data.view._clipRectTrans)
			end
		end, self)

		self._rewardEffect:setParent(self._effectGo.transform)

		local scale = 0.8

		self._rewardEffect:setScale(scale)
	end
end

function MaterialStageItem:_onEffectLoaded(uiEffect, clipRectTrans)
	if uiEffect.effGo then
		uiEffect.effGo.transform.localPosition = Vector3.New(0, 0, 0)
	end

	uiEffect:setClipping(clipRectTrans)
end

return MaterialStageItem
