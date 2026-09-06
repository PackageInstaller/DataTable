-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjchallengeView.lua

module("logic.extensions.xingjiang.view.XjchallengeView", package.seeall)

local XjchallengeView = class("XjchallengeView", ViewComponent)

function XjchallengeView:ctor()
	XjchallengeView.super.ctor(self)
end

function XjchallengeView:unbindEvents()
	XjchallengeView.super.unbindEvents(self)
	self._introduceBtn:RemoveClickListener()

	for i = 1, 3 do
		self._btnChallenge[i]:RemoveClickListener()
	end
end

function XjchallengeView:bindEvents()
	XjchallengeView.super.bindEvents(self)
	self._introduceBtn:AddClickListener(function()
		PetbookController.instance:openPetinfoView(XingJiangModel.instance.curPetId)
	end, self)

	for i = 1, 3 do
		self._btnChallenge[i]:AddClickListener(function()
			if GameUtil.getUserData("xingjiangover" .. tostring(i)) ~= nil then
				FloatWordMgr.instance:show("已通过所有关卡")
			else
				UIStateManager.instance:push(string.format("xjlevels%dview", i))
			end
		end, self)
	end
end

function XjchallengeView:buildUI()
	XjchallengeView.super.buildUI(self)

	self._sprintGo = self:getGo("con")
	self._introduceBtn = self:getBtn("petInfo/btnIntroduce")
	self._sprintRareGo = self:getGo("petInfo/pointRare")
	self._btnChallenge = {}

	for i = 1, 3 do
		self._btnChallenge[i] = self:getBtn("btnChallenge" .. i)
	end
end

function XjchallengeView:onExit()
	XjchallengeView.super.onExit(self)

	if self._pmEff then
		UIEffectManager.instance:stopEffect(self._pmEff)
	end

	GlobalDispatcher:removeListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ZXL_GETSIGN, self.onRefreshUI, self)
	MaterialMgr.resetAll(self._sprintRareGo)
end

function XjchallengeView:onEnter()
	XjchallengeView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_IF_GETINFORES, self.onRefreshUI, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ZXL_GETSIGN, self.onRefreshUI, self)

	self.curActId = XingJiangModel.instance.curActId

	XingJiangController.instance:sendInfoReq(self.curActId)
	self:_showSpriteRawInfo()
	self:_showUIEff()
end

function XjchallengeView:onRefreshUI()
	for i = 2, 3 do
		local curAct = XingJiangModel.instance.actIdList[i]
		local actType = math.floor(curAct / 1000)
		local isInTime = ActivityDefineController.instance:isInActivityTimeById(actType, curAct)
		local lock = goutil.findChild(self._btnChallenge[i].gameObject, "lock")

		lock:SetActive(not isInTime)

		self._btnChallenge[i].btn.enabled = isInTime
	end
end

function XjchallengeView:_showSpriteRawInfo()
	MaterialMgr.setCell(MatType.Rare, XingJiangModel.instance.curPetId, self._sprintRareGo)

	local x, y, scale = 0, 0, 1

	self._roleModel = RoleObjectPool.instance:removeRole(self._roleModel)
	self._roleModel = RoleObjectPool.instance:addRoleToParent(self._roleModel, XingJiangModel.instance.curPetId, self._sprintGo, scale, nil, true, x, y)
end

function XjchallengeView:_showUIEff()
	local effPath = "fx_ui_tongtiaozhan/fx_ui_mianban_tongtiaozhan.prefab"

	self._pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self._pmEff:setParent(self.mainGO.transform)
	self._pmEff:setLocalPos(0, 0, 0)
	self._pmEff:setScale(1)
end

return XjchallengeView
