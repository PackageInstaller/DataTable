-- chunkname: @modules/logic/partygame/view/decision/DecisionInputComp.lua

module("modules.logic.partygame.view.decision.DecisionInputComp", package.seeall)

local DecisionInputComp = class("DecisionInputComp", LuaCompBase)

function DecisionInputComp:init(go)
	self._operRoot = gohelper.findChild(go, "arrows")
	self._goscoreitem = gohelper.findChild(go, "#go_score")
	self._btnUp = gohelper.findChildButtonWithAudio(self._operRoot, "up")
	self._btnDown = gohelper.findChildButtonWithAudio(self._operRoot, "down")
	self._btnLeft = gohelper.findChildButtonWithAudio(self._operRoot, "left")
	self._btnRight = gohelper.findChildButtonWithAudio(self._operRoot, "right")
	self._goSelectUp = gohelper.findChild(self._operRoot, "up/selected")
	self._goSelectDown = gohelper.findChild(self._operRoot, "down/selected")
	self._goSelectLeft = gohelper.findChild(self._operRoot, "left/selected")
	self._goSelectRight = gohelper.findChild(self._operRoot, "right/selected")
	self._goscoreroot = gohelper.create2d(go, "scoreRoot")
	self._uiFollower = gohelper.onceAddComponent(self._operRoot, typeof(ZProj.UIFollower))

	self._uiFollower:SetEnable(true)

	local uid = PartyGameController.instance:getCurPartyGame():getMainPlayerUid()
	local trans = PartyGame.Runtime.GameLogic.GameInterfaceBase.GetPlayerTransform(uid)
	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower:Set(mainCamera, uiCamera, plane, trans, 0, 0.4, 0, 0, 0)
	gohelper.setActive(self._operRoot, false)

	local posDict = GameUtil.splitString2(PartyGameConfig.instance:getConstValue(70002), true)
	local arr = {}

	for i = 1, 5 do
		arr[i] = {
			index = i * 2 - 1,
			pos = Vector3(posDict[i][1], posDict[i][2], posDict[i][3])
		}
	end

	self._scoreComps = {}

	gohelper.CreateObjList(self, self._createScoreItem, arr, self._goscoreroot, self._goscoreitem, DecisionScoreComp, nil, nil, 1)
end

function DecisionInputComp:addEventListeners()
	self._btnLeft:AddClickListener(self._onClick, self, PartyGameEnum.VirtualButtonId.button1)
	self._btnRight:AddClickListener(self._onClick, self, PartyGameEnum.VirtualButtonId.button2)
	self._btnUp:AddClickListener(self._onClick, self, PartyGameEnum.VirtualButtonId.button3)
	self._btnDown:AddClickListener(self._onClick, self, PartyGameEnum.VirtualButtonId.button4)
end

function DecisionInputComp:removeEventListeners()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnUp:RemoveClickListener()
	self._btnDown:RemoveClickListener()
end

function DecisionInputComp:_createScoreItem(obj, data, index)
	obj:initData(data)

	self._scoreComps[index] = obj
end

function DecisionInputComp:viewDataUpdate()
	local uid = PartyGameController.instance:getCurPartyGame():getMainPlayerUid()
	local isShowOper = PartyGameCSDefine.DecisionGameInterfaceCs.IsShowOper()

	gohelper.setActive(self._operRoot, isShowOper)
	gohelper.setActive(self._goscoreroot, isShowOper)

	if isShowOper then
		for k, v in pairs(self._scoreComps) do
			v:update()
		end

		if not self._posIndex then
			self._posIndex = PartyGameCSDefine.DecisionGameInterfaceCs.GetPlayerPosIndex(uid)

			gohelper.setActive(self._btnUp, self:isShowOper(self._posIndex, 1))
			gohelper.setActive(self._btnDown, self:isShowOper(self._posIndex, 2))
			gohelper.setActive(self._btnLeft, self:isShowOper(self._posIndex, 3))
			gohelper.setActive(self._btnRight, self:isShowOper(self._posIndex, 4))
		end

		local selectIndex = PartyGameCSDefine.DecisionGameInterfaceCs.GetPlayerSelectIndex(uid)

		gohelper.setActive(self._goSelectLeft, selectIndex == self._posIndex - 1)
		gohelper.setActive(self._goSelectRight, selectIndex == self._posIndex + 1)
		gohelper.setActive(self._goSelectUp, selectIndex == self._posIndex - 3)
		gohelper.setActive(self._goSelectDown, selectIndex == self._posIndex + 3)
	end
end

function DecisionInputComp:isShowOper(index, dir)
	if dir == 1 then
		return index > 3
	elseif dir == 2 then
		return index <= 6
	elseif dir == 3 then
		return index % 3 ~= 1
	elseif dir == 4 then
		return index % 3 ~= 0
	end
end

function DecisionInputComp:_onClick(btnId)
	PartyGameEnum.CommandUtil.CreateButtonCommand(btnId)
end

return DecisionInputComp
