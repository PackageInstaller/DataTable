-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZoopairView.lua

module("logic.extensions.zoo.view.ZoopairView", package.seeall)

local ZoopairView = class("ZoopairView", ViewComponent)
local matchAnimationTime = 5.4

function ZoopairView:buildUI()
	ZoopairView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._geneCell = self:getGo("item_gene")

	self:_initLeftView()
	self:_initRightView()

	self._enterBtn = self:getBtn("enterBtn")
	self._enterBtnText = self:getTxt("enterBtn/Text")
	self._animalViewGo = self:getGo("animalView")
	self._animalCell = self:getGo("animalCell")
	self._animalView = ScrollerList.create(self._animalViewGo, self._animalCell, GameUtil.handler(self._updateAnimalCell, self))
	self._confirmBtn = self:getBtn("confirmBtn")
	self._timeText = self:getTxt("time")
	self._midEffGo = self:getGo("midEff")
end

function ZoopairView:_initLeftView()
	self._left = self:getGo("left")
	self._leftName = self:getTxt("left/name")
	self._leftGeneView = ScrollerList.create(self:getGo("left/geneView"), self._geneCell, GameUtil.handler(self._updateGeneCell, self))
	self._leftInfoBg = self:getGo("left/infobg")
	self._leftHead = self:getGo("left/userHead")
	self._leftUserName = self:getTxt("left/userHead/name")
	self._leftReady = self:getTxt("left/userHead/ready")
	self._leftCancelBtn = self:getBtn("left/cancelBtn")
end

function ZoopairView:_initRightView()
	self._right = self:getGo("right")
	self._rightName = self:getTxt("right/name")
	self._rightGeneView = ScrollerList.create(self:getGo("right/geneView"), self._geneCell, GameUtil.handler(self._updateGeneCell, self))
	self._rightInfoBg = self:getGo("right/infobg")
	self._rightHead = self:getGo("right/userHead")
	self._rightUserName = self:getTxt("right/userHead/name")
	self._rightReady = self:getTxt("right/userHead/ready")
	self._waitGo = self:getGo("right/wait")
end

function ZoopairView:bindEvents()
	ZoopairView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._leftCancelBtn:AddClickListener(self._onClickCancel, self)
	self._enterBtn:AddClickListener(self._onClickEnter, self)
	self._confirmBtn:AddClickListener(self._onClickConfirm, self)
end

function ZoopairView:unbindEvents()
	ZoopairView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._leftCancelBtn:RemoveClickListener()
	self._enterBtn:RemoveClickListener()
	self._confirmBtn:RemoveClickListener()
end

function ZoopairView:onEnter()
	ZoopairView.super.onEnter(self)
	self:_initParams()
	self:_updateLeftAnimal()
	self:_updateRightAnimal()
	self:_initViewStatus()
	self:_initAnimalsView()
	self:_initPlayerInfos()
	self:_updateWaitingTime()
	settimer(1, self._tickWaitingReady, self, true)
	GlobalDispatcher:addListener(GlobalNotify.OnZooNotifyPairCancel, self._onZooNotifyPairCancel, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooConfirmBuddyMatch, self._onConfirmBuddyMatch, self)
	GlobalDispatcher:addListener(GlobalNotify.ZooPairCancel, self.close, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooNotifyPairFinish, self._onZooNotifyPairFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooPutBuddyMatchAnimal, self._zooPutBuddyMatchAnimal, self)
	GlobalDispatcher:addListener(GlobalNotify.OnZooNotifyBuddyMatchReady, self._onZooNotifyBuddyMatchReady, self)
	self:_playEffect()
end

function ZoopairView:_initParams()
	self._startMatching = false
	self._cellShow = {}
	self._cellAvatar = {}

	local openParam = self:getOpenParam()

	self._friendMo = FriendModel.instance:getFriendMo(openParam[2])
	self._leftAnimalMo = ZooModel.instance:getMyAnimalById(openParam[1])
	self._invitationFriendMo = openParam[3]
	self._isBeenInvited = self._invitationFriendMo ~= nil
	self._waitingReadyTime = 60

	if self._invitationFriendMo then
		self._rightAnimalMo = self._invitationFriendMo.animalMo or nil
	end
end

function ZoopairView:_initViewStatus()
	goutil.setActive(self._enterBtn.gameObject, false)
	goutil.setActive(self._animalViewGo, self._isBeenInvited)
	goutil.setActive(self._confirmBtn.gameObject, self._isBeenInvited)
end

function ZoopairView:_initAnimalsView()
	if self._isBeenInvited then
		local myZoo = ZooModel.instance:getMyZoo()
		local result = myZoo:getCanPairAnimalList(self._rightAnimalMo.raceId)

		self._animalView:reloadData(result)
	end
end

function ZoopairView:_initPlayerInfos()
	HeadItemController.instance:setHeadCell(self._leftHead, RoleModel.instance:getHeadIconId(), RoleModel.instance:getHeadFrameId(), RoleModel.instance:getVipLvl())

	self._leftUserName.text = RoleModel.instance:getUserName()

	HeadItemController.instance:setHeadCell(self._rightHead, self._friendMo.headIconId, self._friendMo.headFrameId, self._friendMo.vipLv)

	self._rightUserName.text = self._friendMo:getValue("name")
end

function ZoopairView:_playEffect()
	local resPath = "fx_ui_mengchong/fx_ui_chongwugongming_01.prefab"

	self._midEff = UIEffectManager.instance:playEffect(self, resPath, nil, 0, 0, true, false, nil, function(target, eff)
		goutil.addChildToParent(eff.effGo, self._midEffGo)
		Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(eff.effGo.transform, 1, 1, 1)
	end)
end

function ZoopairView:onExit()
	ZoopairView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooNotifyPairFinish, self._onZooNotifyPairFinish, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooNotifyBuddyMatchReady, self._onZooNotifyBuddyMatchReady, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooNotifyPairCancel, self._onZooNotifyPairCancel, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooConfirmBuddyMatch, self._onConfirmBuddyMatch, self)
	GlobalDispatcher:removeListener(GlobalNotify.ZooPairCancel, self.close, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooPutBuddyMatchAnimal, self._zooPutBuddyMatchAnimal, self)
	removetimer(self._tickWaitingReady, self)
	removetimer(self._onMatchAnimationFinished, self)

	self._selectId = nil

	UIEffectManager.instance:stopEffect(self._midEff)
end

function ZoopairView:onExitFinished()
	HeadItemController.instance:resetHeadCell(self._leftHead)
	HeadItemController.instance:resetHeadCell(self._rightHead)
	self:_clearLeftAnimalShow()
	self:_clearRightAnimalShow()

	if self._cellShow then
		for k, v in pairs(self._cellShow) do
			v:clear()
			self._cellAvatar[k]:destroy()
		end

		self._cellShow = nil
		self._cellAvatar = nil
	end

	ZoopairView.super.onExitFinished(self)
end

function ZoopairView:_clearLeftAnimalShow()
	if self._leftShow then
		self._leftShow:clear()
		self._leftAvatar:destroy()

		self._leftShow = nil
		self._leftAvatar = nil
	end
end

function ZoopairView:_clearRightAnimalShow()
	if self._rightShow then
		self._rightShow:clear()

		self._rightShow = nil

		self._rightAvatar:destroy()

		self._rightAvatar = nil
	end
end

function ZoopairView:_updateLeftAnimal()
	self:_clearLeftAnimalShow()

	if self._leftAnimalMo then
		self._left:GetComponent(ComponentType.RawImage).enabled = true

		goutil.setActive(self._leftName.gameObject, true)
		goutil.setActive(self._leftReady.gameObject, false)

		self._leftName.text = self._leftAnimalMo.name

		self._leftAnimalMo:refreshAllGeneView(self._leftGeneView)

		self._leftShow, self._leftAvatar = self._leftAnimalMo:showAnimalAvatar(self._left, 600, 500, 0.56, 0.9)

		goutil.setActive(self._leftCancelBtn.gameObject, self._isBeenInvited)
	else
		goutil.setActive(self._leftName.gameObject, false)
		goutil.setActive(self._leftReady.gameObject, true)

		self._left:GetComponent(ComponentType.RawImage).enabled = false

		self._leftGeneView:reloadData({})

		self._leftReady.text = lang("petzoo_match_readying")

		goutil.setActive(self._leftCancelBtn.gameObject, false)
	end
end

function ZoopairView:_updateRightAnimal()
	self:_clearRightAnimalShow()

	if self._rightAnimalMo == nil then
		goutil.setActive(self._rightName.gameObject, false)
		goutil.setActive(self._waitGo, true)

		self._right:GetComponent(ComponentType.RawImage).enabled = false

		self._rightGeneView:reloadData({})

		self._rightReady.text = lang("petzoo_match_readying")
	else
		self._right:GetComponent(ComponentType.RawImage).enabled = true
		self._rightReady.text = lang("petzoo_match_hasready")

		goutil.setActive(self._waitGo, false)
		goutil.setActive(self._rightName.gameObject, true)

		self._rightName.text = self._rightAnimalMo.name

		self._rightAnimalMo:refreshAllGeneView(self._rightGeneView)

		self._rightShow, self._rightAvatar = self._rightAnimalMo:showAnimalAvatar(self._right, 600, 500, 0.56, 0.9)
	end
end

function ZoopairView:_updateGeneCell(view, cell, data)
	local component = ItemGene.AddOnce(cell.gameObject)

	component:setData(data)
end

function ZoopairView:_updateAnimalCell(view, cell, data)
	goutil.setActive(cell.gameObject, true)

	local name = goutil.findChildTextComponent(cell.gameObject, "name")
	local icon = goutil.findChild(cell.gameObject, "icon")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	name.text = data.name

	if self._cellShow[cell] then
		local avatarMo = self._cellAvatar[cell]:getNewUseMo()

		avatarMo:setDataByAnimalMo(data)
		self._cellAvatar[cell]:updateByMo(avatarMo)
	else
		self._cellShow[cell], self._cellAvatar[cell] = data:showAnimalAvatar(icon, 104, 106, 0.56, 0.45)
	end

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		self._selectId = data.id
		self._leftAnimalMo = data

		self:_updateLeftAnimal()
	end)
end

function ZoopairView:_onZooNotifyBuddyMatchReady(animalMo)
	self._rightAnimalMo = animalMo

	self:_updateRightAnimal()
	goutil.setActive(self._enterBtn.gameObject, true)
end

function ZoopairView:_onZooNotifyPairFinish(eggId)
	self._startMatching = true
	self._msgEggId = eggId

	self:_playMatchAnimation()
end

function ZoopairView:_onMatchAnimationFinished()
	self:close()
	UIStateManager.instance:push(ViewName.ZoogetanimaleggView, ZooModel.instance:getEggById(self._msgEggId))
end

function ZoopairView:_onZooNotifyPairCancel()
	self:close()
end

function ZoopairView:_onConfirmBuddyMatch(eggId)
	self._startMatching = true
	self._msgEggId = eggId

	self:_playMatchAnimation()
end

function ZoopairView:_tickWaitingReady()
	if self._waitingReadyTime > 0 then
		self._waitingReadyTime = self._waitingReadyTime - 1

		self:_updateWaitingTime()
	else
		if self._isBeenInvited then
			if self._selectId then
				self:_onClickConfirm()
			end
		elseif self._leftAnimalMo and self._rightAnimalMo then
			self:_onClickEnter()
		else
			self:_onClickClose()
		end

		removetimer(self._tickWaitingReady, self)
	end
end

function ZoopairView:_updateWaitingTime()
	self._timeText.text = self._waitingReadyTime > 10 and string.format(lang("petzoo_match_waitingready_time"), self._waitingReadyTime) or string.format(lang("petzoo_match_waitingready_warningtime"), self._waitingReadyTime)
end

function ZoopairView:_onClickClose()
	if self._startMatching then
		return
	end

	ZooMatchController.instance:sendPM_ZooCancelBuddyMatchReq()
end

function ZoopairView:_onClickCancel()
	self._leftAnimalMo = nil

	self:_updateLeftAnimal()
end

function ZoopairView:_onClickEnter()
	self._startMatching = true

	ZooMatchController.instance:sendPM_ZooConfirmBuddyMatchReq()
end

function ZoopairView:_playMatchAnimation()
	self._leftAvatar.animatorCtrl:setLayer(0)
	self._leftAvatar.animatorCtrl:playAnim(UnityEngine.Animator.StringToHash("Base Layer.lResonance"))
	self._rightAvatar.animatorCtrl:setLayer(0)
	self._rightAvatar.animatorCtrl:playAnim(UnityEngine.Animator.StringToHash("Base Layer.rResonance"))
	settimer(matchAnimationTime, self._onMatchAnimationFinished, self, false)
	goutil.setActive(self._enterBtn.gameObject, false)
end

function ZoopairView:_onClickConfirm()
	if self._selectId then
		goutil.setActive(self._leftCancelBtn.gameObject, false)
		ZooMatchController.instance:sendPM_ZooPutBuddyMatchAnimalReq(self._selectId)
	end
end

function ZoopairView:_zooPutBuddyMatchAnimal()
	goutil.setActive(self._confirmBtn.gameObject, false)
	goutil.setActive(self._animalViewGo, false)
	goutil.setActive(self._leftReady.gameObject, true)

	self._leftReady.text = lang("petzoo_match_hasready")
end

return ZoopairView
