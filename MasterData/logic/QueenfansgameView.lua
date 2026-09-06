-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/darkdragonknife/view/QueenfansgameView.lua

module("logic.extensions.darkdragonknife.view.QueenfansgameView", package.seeall)

local QueenfansgameView = class("QueenfansgameView", DarkDragonKnifeGameView)

function QueenfansgameView:ctor()
	QueenfansgameView.super.ctor(self)
end

function QueenfansgameView:unbindEvents()
	QueenfansgameView.super.unbindEvents(self)
end

function QueenfansgameView:bindEvents()
	QueenfansgameView.super.bindEvents(self)
end

function QueenfansgameView:buildUI()
	QueenfansgameView.super.buildUI(self)
end

function QueenfansgameView:_initDataAndUI()
	self._mainActor.class = DDKMainActor.New(self._goMainActor, self, self._propCfg, self:_ActorPath())
	self._animationScale = 1

	Framework.TransformUtil.SetLocalPos(self._joystickBg.transform, self._initBgPos.x, self._initBgPos.y, 0)

	self._tickedTime = 0
	self._cutTime = 0
	self._tickBornMonsterTime = 0
	self._txtTime.text = langPara("游戏时长：%.2f", self._tickedTime)
	self._towerBlood = self._towerCfg.blood

	self._scoreBarSli:SetValue(1)

	self._killNum = 0

	self:_refreshKillNum()

	self._skill_state = SKILL_STATE_OFF
	self._skillTime = 0
	self._skillKillNum = 0

	goutil.setActive(self._btnSkill.gameObject, false)

	self._comboNum = 0
	self._comboTime = 0

	goutil.setActive(self._killShow, false)
	self:_refreshTowerBlood()
	goutil.setActive(self._startTip, true)

	local startPos = {
		x = -150,
		y = 0
	}

	Framework.TransformUtil.SetAnchoredPos(self._mainActor.rectTrans, startPos.x, startPos.y)
	self._mainActor.class:setDirection(startPos.x < 0, 0.9)

	self._mainActor.pos = startPos

	local url = self:_towerPath()

	self._towerEff = UIEffectManager.instance:playEffect(self.view, url, self._towerAnimation, 0, 0, true, nil, nil, self._onEffectLoaded, self)

	goutil.setActive(self._goTower, true)

	self._monsterDeadIndex = 1

	self:_refreshComboNum()

	self._maxTime = checknumber(DDragonKConfig.instance:getCommonCfg("MAX_GAME_TIME")) + 12
end

function QueenfansgameView:_moveMainActorVelocity(deltaTime, velocity)
	self._rigidbody.velocity = velocity * 0.01

	local x, y, z = Framework.TransformUtil.GetLocalPos(self._mainActor.go.transform, 0, 0, 0)
	local pos = self._mainActor.pos

	pos.x = x
	pos.y = y

	if Mathf.Abs(self._mainActor.velocity.x - 0) > 1e-05 then
		self._mainActor.class:setDirection(self._mainActor.velocity.x < 0, 0.9)
	end
end

function QueenfansgameView:_onEffectLoaded(uiEffect)
	uiEffect:setParent(self._towerAnimation.transform)
	uiEffect:setScale(0.2)
	uiEffect:setLocalPos()

	self._sg = uiEffect.effGo:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	self._effLoaded = true

	self:_playTowerIdleAnimation()
end

function QueenfansgameView:onExit()
	QueenfansgameView.super.onExit(self)
end

function QueenfansgameView:onEnter()
	QueenfansgameView.super.onEnter(self)
end

function QueenfansgameView:_ActorPath()
	return {
		"character/99992_tegongdui/99992_tegongdui-ui_p.prefab"
	}
end

function QueenfansgameView:_towerPath()
	return {
		"character/99983_xingjiang_dakandao/99983_xingjiang_dakandao-ui_p.prefab"
	}
end

return QueenfansgameView
