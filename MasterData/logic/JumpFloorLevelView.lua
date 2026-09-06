-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/view/JumpFloorLevelView.lua

module("logic.extensions.jumpfloor.view.JumpFloorLevelView", package.seeall)

local JumpFloorLevelView = class("JumpFloorLevelView", ViewComponent)

function JumpFloorLevelView:ctor()
	JumpFloorLevelView.super.ctor(self)
end

function JumpFloorLevelView:buildUI()
	JumpFloorLevelView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._txtGameNum = self:getTxt("remain/txtNum")
	self._goCell = self:getGo("level/levelCell")
	self._goTableview = self:getGo("level/tableview")
	self._scrollerList = ScrollerList.create(self._goTableview, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._con = self:getGo("con")
	self._effect = self:getGo("effect")
end

function JumpFloorLevelView:bindEvents()
	JumpFloorLevelView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
end

function JumpFloorLevelView:unbindEvents()
	JumpFloorLevelView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
end

function JumpFloorLevelView:onEnter()
	JumpFloorLevelView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DancingLionJumpGameEndRes, self._onJumpGameEndRes, self)

	self._activityId = self:getFirstParam()
	self._cfgActivity = JumpFloorConfig.instance:getActivityCfg(self._activityId)
	self._stageCfgList = JumpFloorConfig.instance:getStageListById(self._cfgActivity.stagePlanId)

	self:_updateGameNum()
	self:_updateLevels()
	self:_showRoleModel()
	self:_loadEffect()
end

function JumpFloorLevelView:onExit()
	JumpFloorLevelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DancingLionJumpGameEndRes, self._onJumpGameEndRes, self)
	self._scrollerList:dispose()
	self:_resetRoleModel()
	self:_clearEffect()
end

function JumpFloorLevelView:_onClickTip()
	UIStateManager.instance:push(ViewName.RulesView, "jumpfloorlevelview")
end

function JumpFloorLevelView:_updateCell(view, cell, data, tag)
	local cls = GameUtil.AddLuaOnce(cell.gameObject, JumpFloorLevelCell)

	cls:init(data, self._activityId)
end

function JumpFloorLevelView:_clearCell(cell)
	local cls = GameUtil.GetLua(cell.gameObject, JumpFloorLevelCell)

	cls:reset()
end

function JumpFloorLevelView:_updateGameNum()
	local maxNum = self._cfgActivity.dailyTimeLimit
	local curNum = JumpFloorModel.instance:getDailyFinishNum()
	local leftNum = Mathf.Max(0, maxNum - curNum)

	self._txtGameNum.text = string.format("今日剩余次数：<color=#%sFF>%d</color>/%d", ColorConst.Red, leftNum, maxNum)
end

function JumpFloorLevelView:_updateLevels()
	self._scrollerList:reloadData(self._stageCfgList)
	self._scrollerList:MoveCellToCenter(JumpFloorModel.instance:getFinishNum())
end

function JumpFloorLevelView:_onJumpGameEndRes()
	self:_updateGameNum()
	self:_updateLevels()
end

function JumpFloorLevelView:_showRoleModel()
	self:_resetRoleModel()

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, 17021, self._con, 1, nil, true, 0, 0)
end

function JumpFloorLevelView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function JumpFloorLevelView:_loadEffect()
	self:_clearEffect()

	local path = "20230120/kaizhuangqiwu/fx_ui_kzqw_fw.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._effect.transform, 0, 0, true, false)

	uiEffect:setParent(self._effect.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._bgEffect = uiEffect
end

function JumpFloorLevelView:_clearEffect()
	if self._bgEffect then
		UIEffectManager.instance:stopEffect(self._bgEffect)

		self._bgEffect = nil
	end
end

return JumpFloorLevelView
