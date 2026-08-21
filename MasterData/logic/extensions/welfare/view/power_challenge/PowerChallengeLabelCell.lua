-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/power_challenge/PowerChallengeLabelCell.lua

module("logic.extensions.welfare.view.power_challenge.PowerChallengeLabelCell", package.seeall)

local M = class("PowerChallengeLabelCell")

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
end

function M:buildUI()
	self._lockGo = goutil.findChild(self.mainGO, "content/lock")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "content/txtContent/txtName")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "content/txtContent/txtTime")
	self._selectGo = goutil.findChild(self.mainGO, "select")
	self._btnClick = UIComponentType.ButtonAdapter(goutil.findChild(self.mainGO, "btnClick"))
end

function M:bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:setHandler(obj, func)
	self._handlerObj = obj
	self._handlerFunc = func
end

function M:_onClick()
	if self._handlerFunc then
		self._handlerFunc(self._handlerObj, self._chapterId)
	end
end

function M:updateData(tagTask)
	self._txtName.text = tagTask.name
	self._chapterId = tagTask.chapterId

	local data = PowerChallengeModel.instance:getActivityData()
	local offset = TimeUtil:getNextDayTimeStamp(data:getStartTime(), tagTask.openTime)

	if offset < ServerTime.now() then
		goutil.setActive(self._lockGo, false)
		goutil.setActive(self._txtTime.gameObject, false)
	else
		goutil.setActive(self._lockGo, true)
		goutil.setActive(self._txtTime.gameObject, true)

		self._txtTime.text = TextFormatter.formatFullExpireTime(offset - ServerTime.now())
	end
end

function M:setSelect(status)
	goutil.setActive(self._selectGo, status)
end

return M
