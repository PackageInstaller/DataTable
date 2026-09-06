-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/kjt/FamilytpkrzgameView.lua

module("logic.extensions.familyteamplay.view.game.kjt.FamilytpkrzgameView", package.seeall)

local FamilytpkrzgameView = class("FamilytpkrzgameView", ViewComponent)
local Time2Speed = {
	5,
	4,
	3,
	2,
	1
}

function FamilytpkrzgameView:ctor()
	FamilytpkrzgameView.super.ctor(self)
end

function FamilytpkrzgameView:buildUI()
	FamilytpkrzgameView.super.buildUI(self)

	self._progressBar = self:getSlider("progressBar")
	self._btnKRZ = self:getBtn("btnKRZ")

	self._progressBar:SetValue(0)

	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
	self._roleConGo = self:getGo("rolePoint/parent")
	self._effectGo = self:getGo("effect")
end

function FamilytpkrzgameView:bindEvents()
	FamilytpkrzgameView.super.bindEvents(self)
	self._btnKRZ:AddClickListener(self._onClickbtnKRZ, self)
end

function FamilytpkrzgameView:unbindEvents()
	FamilytpkrzgameView.super.unbindEvents(self)
	self._btnKRZ:RemoveClickListener()
end

function FamilytpkrzgameView:destroyUI()
	FamilytpkrzgameView.super.destroyUI(self)

	self._instanceGo = nil
end

function FamilytpkrzgameView:onEnter()
	FamilytpkrzgameView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataTeamPlaySmallGameEnd, self._updataSmallGameEnd, self)
	GlobalDispatcher:addListener(GlobalNotify.ApplicationResume, self._onHandleOnApplicationResume, self)
	self:_updateView()
end

function FamilytpkrzgameView:onEnterFinished()
	FamilytpkrzgameView.super.onEnterFinished(self)
end

function FamilytpkrzgameView:onExit()
	FamilytpkrzgameView.super.onExit(self)
	removetimer(self._checkGameTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataTeamPlaySmallGameEnd, self._updataSmallGameEnd, self)
	GlobalDispatcher:removeListener(GlobalNotify.ApplicationResume, self._onHandleOnApplicationResume, self)

	self._animator = nil

	removetimer(self._updateTime, self)
	UIEffectManager.instance:stopEffect(self._effectHandler)

	self._effectHandler = nil
end

function FamilytpkrzgameView:onExitFinished()
	FamilytpkrzgameView.super.onExitFinished(self)
end

function FamilytpkrzgameView:_updateView()
	local gameId = self:getFirstParam()

	self._gameRun = true
	self._clickTime = 0
	self._curSpeed = 0
	self._isClickBtn = false
	self._lastClickTime = 0
	self._gameCfg = FamilyteamplayConfig.instance:getSmallGameCfg(gameId)

	local cfg = FamilyteamplayConfig.instance:getSmallGameCfg(gameId)

	self._c2sCfgs = FamilyteamplayConfig.instance:getClick2ScoreCfgs(cfg.typeId)
	self._targetTime = ServerTime.now() + self._gameCfg.gameTime + 1

	self:_setMaxClickTime()
	self:_updateLeftTime()
	self:_setRole()
	self:_setEffect()
	settimer(0, self._updateTime, self, true)
end

function FamilytpkrzgameView:_updateLeftTime()
	self._leftTime = self._targetTime - ServerTime.now()

	if self._leftTime > 0 then
		settimer(1, self._checkGameTime, self, true)
		self:_checkGameTime()
	else
		self:_gameOver()
	end
end

function FamilytpkrzgameView:_updateTime()
	if not self._isClickBtn then
		return
	end

	self._reduceTime = self._reduceTime - Time.deltaTime

	if self._reduceTime <= 0 then
		self._reduceTime = 2

		if self._speedIndex < 5 then
			self._speedIndex = self._speedIndex + 1
		end

		self._curSpeed = Time2Speed[self._speedIndex]

		if self._animator then
			self._animator.speed = self._curSpeed
		end
	end
end

function FamilytpkrzgameView:_checkGameTime()
	self._leftTime = self._leftTime - 1
	self._txtTime.text = self._leftTime .. "秒"

	if self._leftTime <= 0 then
		self:_gameOver()
	end
end

function FamilytpkrzgameView:_setMaxClickTime()
	self._maxClickTime = 0

	for k, v in pairs(self._c2sCfgs) do
		if self._maxClickTime < v.value then
			self._maxClickTime = v.value
		end
	end
end

function FamilytpkrzgameView:_onClickbtnKRZ()
	self._isClickBtn = true
	self._clickTime = self._clickTime + 1

	self._progressBar:SetValue(self._clickTime / self._maxClickTime)

	if self._clickTime >= self._maxClickTime then
		self:_gameOver()
	end

	local speed = 10
	local nowTime = Time.time

	if nowTime - self._lastClickTime <= 1 then
		speed = Time2Speed[1]
		self._speedIndex = 1
	elseif nowTime - self._lastClickTime <= 2 then
		speed = Time2Speed[2]
		self._speedIndex = 2
	elseif nowTime - self._lastClickTime <= 3 then
		speed = Time2Speed[3]
		self._speedIndex = 3
	elseif nowTime - self._lastClickTime <= 4 then
		speed = Time2Speed[4]
		self._speedIndex = 4
	elseif nowTime - self._lastClickTime <= 5 then
		speed = Time2Speed[5]
		self._speedIndex = 5
	else
		speed = Time2Speed[5]
		self._speedIndex = 5
	end

	self._lastClickTime = nowTime

	if speed > self._curSpeed then
		self._curSpeed = speed
	end

	if self._animator then
		self._animator.speed = self._curSpeed
	end

	self._reduceTime = 2
end

function FamilytpkrzgameView:_gameOver()
	if not self._gameRun then
		return
	end

	removetimer(self._checkGameTime, self)

	self._txtTime.text = "已结束"
	self._score = 0

	for i, v in pairs(self._c2sCfgs) do
		if self._clickTime >= v.value and self._score < v.score then
			self._score = v.score
		end
	end

	FamilyteamplayController.instance:csSendTeamPlaySmallGameEndReq(FamilyteamplayModel.instance:getStartSmallGameParam(), self._score)

	self._gameRun = false

	FamilyteamplayController.instance:csSendGetTeamPlayProgressInfoReq()
end

function FamilytpkrzgameView:_updataSmallGameEnd()
	local content = string.format("一共点击了%s下，当前获得积分%s", self._clickTime, self._score)

	TipsFacade.instance:openTipWindowNoX("提示", content, nil)
	self:close()
end

function FamilytpkrzgameView:_onHandleOnApplicationResume()
	self:_updateLeftTime()
end

function FamilytpkrzgameView:_setRole()
	if not self._instanceGo then
		local path = "character/30011_ui_jitui/30011_ui_jitui_p.prefab"
		local go = self._viewPresentor:getResInstance(path)

		if go then
			go.transform:SetParent(self._roleConGo.transform)
			Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
			Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)

			self._animator = go:GetComponent(ComponentType.Animator)
			self._instanceGo = go

			Framework.GameObjectUtil.SetLayerRecursively(go, SceneLayer.UI_Value)
		end
	end

	if self._animator then
		self._animator.speed = 0
	end
end

function FamilytpkrzgameView:_setEffect()
	if not self._effectHandler then
		local path = "fx_ui_jiazuxitong/prefab/fx_ui_kaojitui_jiazu.prefab"

		self._effectHandler = UIEffectManager.instance:playEffect(self, path, nil, 0, 0, true, false)

		self._effectHandler:setParent(self._effectGo.transform)
		self._effectHandler:setScale(1)
		self._effectHandler:setLocalPos(0, 0)
	end
end

return FamilytpkrzgameView
