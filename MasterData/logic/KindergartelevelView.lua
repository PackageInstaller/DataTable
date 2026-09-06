-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergartelevelView.lua

module("logic.extensions.kindergarten.view.KindergartelevelView", package.seeall)

local KindergartelevelView = class("KindergartelevelView", ViewComponent)

function KindergartelevelView:ctor()
	KindergartelevelView.super.ctor(self)
end

function KindergartelevelView:unbindEvents()
	KindergartelevelView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function KindergartelevelView:bindEvents()
	KindergartelevelView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function KindergartelevelView:buildUI()
	KindergartelevelView.super.buildUI(self)

	self._classconGo = self:getGo("classcon")
	self._classcellGo = self:getGo("classcell")
	self._singleLine = self:getGo("classcon"):GetComponent(ComponentType.UILayoutSingleLine)
	self._txtTips = self:getTxt("txtTips")
	self._txtLevel1 = self:getTxt("txtLevel1")
	self._txtLevel2 = self:getTxt("txtLevel2")
	self._txtLimit = self:getTxt("txtLimit")
	self._btnClose = self:getBtn("btnClose")
	self._itemGroup = ItemGroup.New(self._classconGo, self._classcellGo, nil, nil, true)

	goutil.setActive(self._classcellGo, false)
end

function KindergartelevelView:onExit()
	KindergartelevelView.super.onExit(self)
end

function KindergartelevelView:onEnter()
	KindergartelevelView.super.onEnter(self)

	self._activityId = KindergartenModel.instance:getActivityId()

	self:_updateUI()
end

function KindergartelevelView:_onClickbtnClose()
	self:close()
end

function KindergartelevelView:_updateUI()
	self:_updateClass()
end

function KindergartelevelView:_updateClass()
	local classRoomLvs = {}
	local cfgs = KindergartenConfig.instance:getClassRoomCfgs(self._activityId)

	self._itemGroup:updateWithMoArray(cfgs, function(item, cfg)
		local txtLv = goutil.findChildTextComponent(item.mainGO, "txtLv")
		local txtName = goutil.findChildTextComponent(item.mainGO, "txtName")

		txtName.text = cfg.desc

		local level = KindergartenController.instance:getClassRoomLevel(self._activityId, cfg.classroomId)

		txtLv.text = string.format("%s级", level)
		classRoomLvs[cfg.classroomId] = level
	end)
	self._singleLine:Layout()
	self:_updateLevel(classRoomLvs)
end

function KindergartelevelView:_updateLevel(classRoomLvs)
	local maxLevel = -1

	for k, lv in pairs(classRoomLvs) do
		if maxLevel == -1 or lv < maxLevel then
			maxLevel = lv
		end
	end

	local cfgs = KindergartenConfig.instance:getLevelCfgs(self._activityId)
	local kindergartenLevel = 0
	local studentLimit = 0

	for i, v in ipairs(cfgs) do
		if maxLevel == v.needClassroomLv then
			kindergartenLevel = v.level
			studentLimit = v.studentLimit

			break
		end
	end

	self._txtLevel1.text = string.format("%s", kindergartenLevel)
	self._txtLevel2.text = string.format("%s", kindergartenLevel)
	self._txtLimit.text = studentLimit

	self:_updateTips(kindergartenLevel)
end

function KindergartelevelView:_updateTips(kindergartenLevel)
	local cfgs = KindergartenConfig.instance:getLevelCfgs(self._activityId)
	local nextCfg = cfgs[kindergartenLevel + 1]

	self._txtTips.text = nextCfg and string.format("所有课堂均达到%s级后，\n幼儿园等级可升至%s级\n幼儿园最高等级%d级", nextCfg.needClassroomLv, nextCfg.level, #cfgs) or lang("幼儿园等级已达最高级别")
end

return KindergartelevelView
