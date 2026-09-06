-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pigraise/view/PigskinselectView.lua

module("logic.extensions.pigraise.view.PigskinselectView", package.seeall)

local PigskinselectView = class("PigskinselectView", ViewComponent)

function PigskinselectView:ctor()
	PigskinselectView.super.ctor(self)
end

function PigskinselectView:buildUI()
	PigskinselectView.super.buildUI(self)

	self._modelCam = self:getGo("modelCam")
	self._btnClose = self:getBtn("btnClose")
	self._goL = self:getGo("btnArrowL")
	self._goR = self:getGo("btnArrowR")
	self._btnL = GameUtil.asBtn(self._goL)
	self._btnR = GameUtil.asBtn(self._goR)
	self._coms = {}

	for i = 1, 4 do
		local com = {}

		com.go = self:getGo("com" .. i)
		com.btnGo = goutil.findChild(com.go, "btnSure")
		com.change = com.btnGo:GetComponent("UIChangeGroup")
		com.showTxt = goutil.findChildTextComponent(com.btnGo, "Text")
		com.btn = GameUtil.asBtn(com.btnGo)
		com.red = goutil.findChild(com.btnGo, "red")
		com.txtName = goutil.findChildTextComponent(com.go, "txtName")
		com.btnBubble = GameUtil.asBtn(goutil.findChild(com.go, "btnBubble"))
		com.posBubble = goutil.findChild(com.go, "posBubble")
		com.rolePoint = goutil.findChild(self._modelCam, "bgImg/role" .. i)
		com.roleParent = goutil.findChild(com.rolePoint, "point")
		com.petData = nil
		com.avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Pig)

		com.avatar:setParent(com.roleParent.transform)
		com.avatar:setLayer(SceneLayer.UI3D_Value)

		self._coms[i] = com
	end

	self._leftShowId = 1
	self._rightShowId = 3
	self._startId = 1
end

function PigskinselectView:bindEvents()
	PigskinselectView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnL:AddClickListener(function()
		self:_moveRight(false)
	end, self)
	self._btnR:AddClickListener(function()
		self:_moveRight(true)
	end, self)

	for i = 1, 4 do
		self._coms[i].btnBubble:AddClickListener(function()
			self:_playBubble(i)
		end, self)
		self._coms[i].btn:AddClickListener(function()
			self:_onClickBtn(i)
		end, self)
	end
end

function PigskinselectView:unbindEvents()
	PigskinselectView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnL:RemoveClickListener()
	self._btnR:RemoveClickListener()

	for i = 1, 4 do
		self._coms[i].btnBubble:RemoveClickListener()
		self._coms[i].btn:RemoveClickListener()
	end
end

function PigskinselectView:destroyUI()
	PigskinselectView.super.destroyUI(self)

	for i = 1, 4 do
		if self._coms[i].avatar then
			AvatarsMgrNew.instance:removeAvatar(self._coms[i].avatar)

			self._coms[i].avatar = nil
		end
	end
end

function PigskinselectView:onEnter()
	self._ableToSend = true

	PigskinselectView.super.onEnter(self)

	self._petDatas = PigraiseModel.instance:getAllPetInfo()

	goutil.addChildToParent(self._modelCam)
	GlobalModel.instance:visibleSceneHUDs(false)
	self:_updateMobeBtn()
	self:_updateCom(self._leftShowId, self._startId)
	self:_updateCom(self:_getNewId(self._leftShowId + 1), self._startId + 1)
	self:_updateCom(self._rightShowId, self._startId + 2)
	self:_updateCom(self:_getNewId(self._leftShowId - 1))
end

function PigskinselectView:onEnterFinished()
	PigskinselectView.super.onEnterFinished(self)
end

function PigskinselectView:onExit()
	PigskinselectView.super.onExit(self)
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	self:_finishPlayBubble()
	removetimer(self._finishPlayBubble, self)

	for i = 1, 4 do
		self._coms[i].petData = nil

		if self._coms[i].avatar then
			self._coms[i].avatar:reset()
		end
	end
end

function PigskinselectView:onExitFinished()
	PigskinselectView.super.onExitFinished(self)
end

function PigskinselectView:_moveRight(isMoveRight)
	self:_finishPlayBubble()

	if not self._leftShowId or not self._rightShowId then
		return
	end

	if isMoveRight then
		if self._startId + 3 > #self._petDatas then
			self:_updateMobeBtn()

			return
		end

		self._leftShowId = self:_getNewId(self._leftShowId + 1)
		self._rightShowId = self:_getNewId(self._rightShowId + 1)
		self._startId = self._startId + 1

		self:_updateCom(self:_getNewId(self._leftShowId - 1))
		self:_updateRolePos()
		self:_updateCom(self._rightShowId, self._startId + 2)
	else
		if self._startId - 1 <= 0 then
			self:_updateMobeBtn()

			return
		end

		self._leftShowId = self:_getNewId(self._leftShowId - 1)
		self._rightShowId = self:_getNewId(self._rightShowId - 1)
		self._startId = self._startId - 1

		self:_updateCom(self:_getNewId(self._rightShowId + 1))
		self:_updateRolePos()
		self:_updateCom(self._leftShowId, self._startId)
	end

	self:_updateMobeBtn()
end

function PigskinselectView:_updateMobeBtn()
	goutil.setActive(self._goL, self._startId - 1 > 0)
	goutil.setActive(self._goR, self._startId + 3 <= #self._petDatas)
end

function PigskinselectView:_updateRolePos()
	GameUtil.setLocalPos(self._coms[self._leftShowId].go, -293, 0)
	GameUtil.setLocalPos(self._coms[self._leftShowId].rolePoint, -293, -140)
	GameUtil.setLocalPos(self._coms[self:_getNewId(self._leftShowId + 1)].go, 13, 0, 0)
	GameUtil.setLocalPos(self._coms[self:_getNewId(self._leftShowId + 1)].rolePoint, 13, -140)
	GameUtil.setLocalPos(self._coms[self._rightShowId].go, 316, 0, 0)
	GameUtil.setLocalPos(self._coms[self._rightShowId].rolePoint, 316, -140)
end

function PigskinselectView:_updateCom(moveId, dataId)
	print(">>>>>>>>>>>>>> _updateCom", moveId, dataId)
	goutil.setActive(self._coms[moveId].go, false)
	goutil.setActive(self._coms[moveId].rolePoint, false)

	if dataId and self._petDatas[dataId] then
		goutil.setActive(self._coms[moveId].go, true)
		goutil.setActive(self._coms[moveId].rolePoint, true)
		self:_updateComData(moveId, self._petDatas[dataId])
	end
end

function PigskinselectView:_updateComData(moveId, data)
	local com = self._coms[moveId]

	if com.petData ~= data then
		com.avatar:reset()
		com.avatar:setParent(com.roleParent.transform)
		com.avatar:setLayer(SceneLayer.UI3D_Value)

		com.txtName.text = data.name

		if not data.cfg.bubblePos2 then
			GameUtil.setLocalPos(com.posBubble, checknumber(data.cfg.bubblePos2[1]), checknumber(data.cfg.bubblePos2[2]))

			com.petData = data

			com.avatar:updateByMo(data:getPetAvatarMo())
			self:_updateComBtn(com)
		end
	end
end

function PigskinselectView:_updateComBtn(com)
	goutil.setActive(com.red, false)

	local data = com.petData
	local state = data:getCurState()

	if state == 1 then
		com.showTxt.text = "解锁"

		com.change:SetState(0)
		goutil.setActive(com.red, true)
	elseif state == 2 then
		com.showTxt.text = "使用中"

		com.change:SetState(0)

		self._curTakeCom = com
	elseif state == 3 then
		com.showTxt.text = "切换使用"

		com.change:SetState(1)
	else
		com.showTxt.text = "前往获取"

		com.change:SetState(1)
	end
end

function PigskinselectView:_getNewId(id)
	if id then
		if id > 4 then
			return 1
		elseif id < 1 then
			return 4
		else
			return id
		end
	end
end

function PigskinselectView:_onClickBtn(id)
	if self._ableToSend then
		local com = self._coms[id]
		local data = com.petData
		local state = data:getCurState()

		if state == 1 then
			self._ableToSend = false

			PigraiseController.instance:activatePetReq(data.defineId, function()
				self._petDatas = PigraiseModel.instance:getAllPetInfo()

				self:_updateCom(self._leftShowId, self._startId)
				self:_updateCom(self:_getNewId(self._leftShowId + 1), self._startId + 1)
				self:_updateCom(self._rightShowId, self._startId + 2)
				self:_updateCom(self:_getNewId(self._leftShowId - 1))
				self:_updateMobeBtn()

				self._ableToSend = true
			end, self)
		elseif state == 2 then
			printf("使用中")
		elseif state == 3 then
			self._ableToSend = false

			PigraiseController.instance:takePetReq(data.id, function(msg)
				self._startId = 1

				PigraiseModel.instance:updateTake(data.id)

				self._petDatas = PigraiseModel.instance:getAllPetInfo()

				self:_updateCom(self._leftShowId, self._startId)
				self:_updateCom(self:_getNewId(self._leftShowId + 1), self._startId + 1)
				self:_updateCom(self._rightShowId, self._startId + 2)
				self:_updateCom(self:_getNewId(self._leftShowId - 1))
				self:_updateMobeBtn()

				self._ableToSend = true
			end, self)
		else
			printf("前往")
			MaterialMgr.openGetSourceByStr(data.cfg.activateItem)
		end
	else
		FloatWordMgr.instance:show("点击过于频繁")
	end
end

function PigskinselectView:_playBubble(id)
	self:_finishPlayBubble()

	if not self._isPlayBubble then
		local newstr = self._coms[id].petData.cfg.talk

		if newstr then
			self._isPlayBubble = true

			BubbleController.instance:OpenView(newstr, self._coms[id].posBubble.transform.position, true)
			settimer(2.5, self._finishPlayBubble, self, false)
		end
	end
end

function PigskinselectView:_finishPlayBubble()
	BubbleController.instance:CloseView()

	self._isPlayBubble = false
end

return PigskinselectView
