-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kindergarten/view/KindergarteEnlistSuccessView.lua

module("logic.extensions.kindergarten.view.KindergarteEnlistSuccessView", package.seeall)

local KindergarteEnlistSuccessView = class("KindergarteEnlistSuccessView", ViewComponent)

function KindergarteEnlistSuccessView:buildUI()
	KindergarteEnlistSuccessView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtTipsCost = goutil.findChildTextComponent(self.mainGO, "txtTipsCost")
	self._txtTipsGet = goutil.findChildTextComponent(self.mainGO, "txtTipsGet")
end

function KindergarteEnlistSuccessView:bindEvents()
	KindergarteEnlistSuccessView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function KindergarteEnlistSuccessView:unbindEvents()
	KindergarteEnlistSuccessView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function KindergarteEnlistSuccessView:onEnter()
	KindergarteEnlistSuccessView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._enlistId = checknumber(params[2])
	self._enlistData = KindergartenConfig.instance:getEnlistData(self._activityId, self._enlistId)
	self._matStr = self._enlistData.cost
	self._matType, self._matId, self._costNum = MaterialMgr.getMatParams(self._enlistData.cost)
	self._matName = MaterialMgr.getMaterialsName(self._matType, self._matId)
	self._matNum = MaterialModel.instance:getMaterialsNumber(self._matType, self._matId)

	self.addGEvent(self, GlobalNotify.KindergartenAddStudentRes, self._onUpdate, self)
	self:_onUpdate()
end

function KindergarteEnlistSuccessView:onExit()
	KindergarteEnlistSuccessView.super.onExit(self)
end

function KindergarteEnlistSuccessView:_onUpdate()
	self._msg = KindergartenModel.instance:getAddStudentResMsg()

	if self._msg then
		self._getStuNum = #self._msg.studentList or 0
	end

	self._totalCostMatNum = self._getStuNum * self._costNum
	self._txtTipsCost.text = string.format("%s*%s", self._matName, self._totalCostMatNum)

	local stuNums = {}

	if self._msg then
		for i, v in ipairs(self._msg.studentList) do
			stuNums[v.studentType] = (stuNums[v.studentType] or 0) + 1
		end
	end

	local strs = {}

	for k, v in pairs(stuNums) do
		local name = KindergarteEnum.StuTypeNames[k]

		table.insert(strs, string.format("%s:%s", name, v))
	end

	local str = ""

	for i, v in ipairs(strs) do
		str = i < #strs and str .. v .. ", " or str .. v
	end

	self._txtTipsGet.text = str
end

return KindergarteEnlistSuccessView
