-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/view/NineplacebuffenemyView.lua

module("logic.extensions.nineplacebuffenemy.view.NineplacebuffenemyView", package.seeall)

local NineplacebuffenemyView = class("NineplacebuffenemyView", ViewComponent)

function NineplacebuffenemyView:ctor()
	NineplacebuffenemyView.super.ctor(self)
end

function NineplacebuffenemyView:buildUI()
	NineplacebuffenemyView.super.buildUI(self)

	self._maskBg = GameUtil.asBtn(self:getGo("maskBg"))
	self._imgIcon = self:getGo("bg/imgIcon")
	self._nameText = goutil.findChildTextComponent(self.mainGO, "bg/nameText")
	self._buffText = goutil.findChildTextComponent(self.mainGO, "bg/buffText")
end

function NineplacebuffenemyView:bindEvents()
	NineplacebuffenemyView.super.bindEvents(self)
	self._maskBg:AddClickListener(self.onClickClose, self)
end

function NineplacebuffenemyView:unbindEvents()
	NineplacebuffenemyView.super.unbindEvents(self)
	self._maskBg:RemoveClickListener()
end

function NineplacebuffenemyView:destroyUI()
	NineplacebuffenemyView.super.destroyUI(self)
end

function NineplacebuffenemyView:onEnter()
	NineplacebuffenemyView.super.onEnter(self)

	self._enemyFormation = self:getFirstParam()

	local info = BattleConfig.instance:getFormStrengthLvCfg(self._enemyFormation.formStrengthId, self._enemyFormation.formStrengthLv)

	if info then
		self._nameText.text = info.name

		local list = FightingPowerFormula.instance:parseAttrValues(info.properties)
		local str = ""

		for i, v in pairs(list) do
			local name, value, symbol = GameUtil.getPropertyInfo(i, v)

			str = str .. name .. " " .. symbol .. value .. "  "
		end

		self._buffText.text = str
	else
		self._nameText.text = "未设置阵型"
		self._buffText.text = ""
	end
end

function NineplacebuffenemyView:onEnterFinished()
	NineplacebuffenemyView.super.onEnterFinished(self)
end

function NineplacebuffenemyView:onExit()
	NineplacebuffenemyView.super.onExit(self)
end

function NineplacebuffenemyView:onExitFinished()
	NineplacebuffenemyView.super.onExitFinished(self)
end

function NineplacebuffenemyView:onClickClose()
	self:close()
end

return NineplacebuffenemyView
