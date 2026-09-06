-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/materialchallenge/view/StarGodStageItem.lua

module("logic.extensions.materialchallenge.view.StarGodStageItem", package.seeall)

local StarGodStageItem = class("StarGodStageItem")

function StarGodStageItem:ctor(luaComponentContainer)
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
	self._txtSingle = goutil.findChildTextComponent(go, "node/txtSingle")
	self._txtTeam = goutil.findChildTextComponent(go, "node/txtTeam")
	self._gameMaxCount = checknumber(StarGodChallengeConfig.instance:getConstValue("TODAY_GAME_TIMES"))
end

function StarGodStageItem:init(index, data, view)
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

	self._txtNames.text = data.name

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

	local isPass = false

	self:_setIsNewStageSymbol(isPass)
	self:_setText()
end

function StarGodStageItem:_setIsNewStageSymbol(isPass)
	local isMarked = GameUtil.getUserData(CopyConst.isNewResStage .. "StarGodStageItem")

	self._effectGo:SetActive(not self._data.isLock)
	self:_updateRewardEffect(not self._data.isLock)
	self:_setImgNew()
end

function StarGodStageItem:_setImgNew()
	local startTime = "2022-07-29 05:00:00"
	local endTime = "2022-08-05 05:00:00"
	local curTime = ServerTime.now()

	goutil.setActive(self._imgNews, GameUtil.checkIsInTimePeriod(startTime, endTime))
end

function StarGodStageItem:_updateRewardEffect(isShow)
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

function StarGodStageItem:_onEffectLoaded(uiEffect, clipRectTrans)
	if uiEffect.effGo then
		uiEffect.effGo.transform.localPosition = Vector3.New(0, 0, 0)
	end

	uiEffect:setClipping(clipRectTrans)
end

function StarGodStageItem:_getNodePos(index)
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

function StarGodStageItem:_getLinePos(index)
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

function StarGodStageItem:_getLineEulerZ(index)
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

function StarGodStageItem:_getLineWidth(index)
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

function StarGodStageItem:reset()
	self._data = nil
	self._view = nil

	self._btnClick:RemoveClickListener()
	self:_updateRewardEffect(false)
end

function StarGodStageItem:_onBtnClick()
	if self._data.isLock then
		FloatWordMgr.instance:show("前置关卡皆为S评分可开启拓展挑战")
	else
		SurveyController.instance:reportBehavior(SurveyBehaviorID.StarGodChallenge1)
		UIStateManager.instance:push(ViewName.StarGodChallengeMainView)
	end
end

function StarGodStageItem:_setText()
	goutil.setActive(self._txtSingle.gameObject, true)
	goutil.setActive(self._txtTeam.gameObject, false)

	local curSingleTimes = StarGodChallengeModel.instance:getTodayGameTimes()
	local singleLeftTime = self._gameMaxCount - curSingleTimes

	singleLeftTime = singleLeftTime >= 0 and singleLeftTime or 0
	self._txtSingle.text = string.format("游戏次数：%d/%d", singleLeftTime, self._gameMaxCount)
end

return StarGodStageItem
