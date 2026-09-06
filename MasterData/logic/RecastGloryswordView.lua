-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastGloryswordView.lua

module("logic.extensions.recastglory.view.RecastGloryswordView", package.seeall)

local RecastGloryswordView = class("RecastGloryswordView", ViewComponent)

function RecastGloryswordView:ctor()
	RecastGloryswordView.super.ctor(self)
end

function RecastGloryswordView:unbindEvents()
	RecastGloryswordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnHit)
end

function RecastGloryswordView:bindEvents()
	RecastGloryswordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnHit, self._onClickHit, self)
end

function RecastGloryswordView:buildUI()
	RecastGloryswordView.super.buildUI(self)

	self._sword = self:getGo("sword")
	self._handle = self:getGo("sword/effect/handle")
	self._success = self:getGo("success")
	self._con = self:getGo("success/con")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._btnHit = self:getBtn("btnHit")
	self._moveEffectDot = RecastGloryHitdot.New(self._handle)

	local hitDotTrans = self:getGo("sword/hitDots").transform
	local swordBodyTrans = self:getGo("sword/body").transform

	self._hitDots = {}

	for i = 1, hitDotTrans.childCount do
		local child = {}

		child.go = hitDotTrans:GetChild(i - 1)
		child.hitDot = RecastGloryHitdot.New(child.go)
		child.body = swordBodyTrans:GetChild(i - 1)
		child.dirtys = {}

		for i = 1, child.body.transform.childCount do
			local dirty = goutil.findChild(child.body, "dirty_" .. i)

			table.insert(child.dirtys, dirty)
		end

		child.txt = goutil.findChildTextComponent(child.go, "count")

		table.insert(self._hitDots, child)
	end
end

function RecastGloryswordView:onExit()
	RecastGloryswordView.super.onExit(self)
	self._moveEffectDot:onExit()

	for _, child in ipairs(self._hitDots) do
		child.hitDot:onExit()
	end

	UIEffectManager.instance:stopEffect(self._pmEff)
	UnityTweens.TweenPosition.StopTween(self._handle)
end

function RecastGloryswordView:onEnter()
	RecastGloryswordView.super.onEnter(self)

	local params = self:getOpenParam()

	self._gameId = checknumber(params[1])
	self._successCallBack = params[2]
	self._gameSwordData = RecastGloryConfig.instance:getGloryGameSwordCfg(self._gameId)

	local key = string.format("%s_%s", ViewName.RecastGloryswordView, self._gameId)

	local function firstTimeCallback()
		self:_openRuleView()
	end

	GameUtil.doCallbackWhenFirst(key, firstTimeCallback, nil)

	self._hitCountArr = self._gameSwordData.hitCountArr or {}

	self:_initSwordUI()
	self._moveEffectDot:onEnter()
	UnityTweens.TweenPosition.StartTween(self._handle, Vector3.New(-234, 0, 0), Vector3.New(234, 0, 0), 4, UnityTweens.EaseType.linear)
end

function RecastGloryswordView:_initSwordUI()
	for i, child in ipairs(self._hitDots) do
		child.hitDot:onEnter()

		local count = checknumber(self._hitCountArr[i])

		child.hitDot:_setHitTotalCount(count)

		child.txt = goutil.findChildTextComponent(child.go, "count")
		child.txt.text = string.format("<color=#eb4642>%d</color>/%d", child.hitDot:_getCurHitCount(), checknumber(self._hitCountArr[i]))

		for _, dirty in ipairs(child.dirtys) do
			GameUtil.SetActive(dirty, true)
		end
	end
end

function RecastGloryswordView:_onClickHit()
	local isHit = false

	for i, child in ipairs(self._hitDots) do
		local dotBox = child.hitDot:getBoundingBox()
		local effectBox = self._moveEffectDot:getBoundingBox()

		if dotBox:intersects(effectBox) then
			child.hitDot:_addHitCount()

			local count = child.hitDot:_getCurHitCount()

			GameUtil.SetActive(child.dirtys[count], false)

			child.txt.text = string.format("<color=#eb4642>%d</color>/%d", child.hitDot:_getCurHitCount(), checknumber(self._hitCountArr[i]))
			isHit = true

			local path = "20230331/chongzhurongguang/fx_ui_chongzhurongguang_duanzao.prefab"

			self._pmEff = UIEffectManager.instance:playEffect(self, path, child.go.transform, 0, 0, false, nil, nil, nil, self)

			self._pmEff:setParent(child.go.transform)
			self._pmEff:setLocalPos(0, 0, 0)
			self._pmEff:setScale(1)
		end
	end

	if self:_isAllHit() then
		self:_showSuccess()

		return
	end

	if not isHit then
		FloatWordMgr.instance:show("锻造的位置错了，再来一次吧~")
	end
end

function RecastGloryswordView:_isAllHit()
	for i, child in ipairs(self._hitDots) do
		local count = child.hitDot:_getCurHitCount()

		if count < checknumber(self._hitCountArr[i]) then
			return false
		end
	end

	return true
end

function RecastGloryswordView:_showSuccess()
	GameUtil.callBack(self._successCallBack)
	GameUtil.SetActive(self._sword, false)
	GameUtil.SetActive(self._success, true)
	self:_showPet()
	FloatWordMgr.instance:show(self._gameSwordData.descSuccess)
end

function RecastGloryswordView:_showPet()
	settimer(2, self._stroyPlay, self, false)
end

function RecastGloryswordView:_stroyPlay()
	StoryController.instance:startStory(self._gameSwordData.storyId)
	removetimer(self._stroyPlay, self)
end

function RecastGloryswordView:_onClickTip()
	self:_openRuleView()
end

function RecastGloryswordView:_openRuleView()
	UIStateManager.instance:push(ViewName.RecastGloryruleView, self._gameSwordData.ruleId)
end

return RecastGloryswordView
