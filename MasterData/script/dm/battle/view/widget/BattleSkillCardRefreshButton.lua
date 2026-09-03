-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleSkillCardRefreshButton.lua

BattleSkillCardRefreshButton = class("BattleSkillCardRefreshButton", BattleWidget, _M)

function BattleSkillCardRefreshButton:initialize(view)
	super.initialize(self, view)
end

function BattleSkillCardRefreshButton:init(num)
	self._energyCost = num
	self._energy = 0

	self:_setupView()
end

function BattleSkillCardRefreshButton:_setupView()
	self._buttonRefresh = self:getView():getChildByName("button_refresh")
	self._energyLab = self:getView():getChildByName("energy_lab")

	self._energyLab:setString(self._energyCost)
	self._buttonRefresh:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
			self:onClickRefresh()
		end
	end)
end

function BattleSkillCardRefreshButton:setListener(listener)
	self._listener = listener
end

function BattleSkillCardRefreshButton:show()
	self:getView():setVisible(false)
end

function BattleSkillCardRefreshButton:hide()
	self:getView():setVisible(false)
end

function BattleSkillCardRefreshButton:onClickRefresh()
	if self._energy < self._energyCost then
		return
	end

	if self._listener then
		self._listener:refreshSkillCard()
	end
end

function BattleSkillCardRefreshButton:syncEnergy(energy)
	self._energy = energy

	if self._energy < self._energyCost then
		self:getView():setGray(true)
	else
		self:getView():setGray(false)
	end
end
