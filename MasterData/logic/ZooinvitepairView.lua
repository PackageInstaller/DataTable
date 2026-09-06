-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/zoo/view/ZooinvitepairView.lua

module("logic.extensions.zoo.view.ZooinvitepairView", package.seeall)

local ZooinvitepairView = class("ZooinvitepairView", ViewComponent)

function ZooinvitepairView:buildUI()
	ZooinvitepairView.super.buildUI(self)

	self._friendCell = self:getGo("bg/cell")
	self._friendView = ScrollerList.create(self:getGo("bg/friendList/view"), self._friendCell, GameUtil.handler(self._updateFriendCell, self), GameUtil.handler(self._clearFriendCell, self))
	self._closeBtn = self:getBtn("bg/close")
	self._animalIcon = self:getGo("bg/animalIcon")
	self._name = self:getTxt("bg/animalIcon/txtName")
	self._times = self:getTxt("bg/animalIcon/times")
	self._geneCell = self:getGo("bg/item_gene")
	self._normal = self:getGo("bg/normal/sc")
	self._normalView = ScrollerList.create(self._normal, self._geneCell, GameUtil.handler(self._updateGeneCell, self))
	self._special = self:getGo("bg/special/sc")
	self._specialView = ScrollerList.create(self._special, self._geneCell, GameUtil.handler(self._updateGeneCell, self))
	self._empty = self:getGo("bg/empty")
end

function ZooinvitepairView:bindEvents()
	ZooinvitepairView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function ZooinvitepairView:unbindEvents()
	ZooinvitepairView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function ZooinvitepairView:onEnter()
	ZooinvitepairView.super.onEnter(self)

	self._animalMo = self:getFirstParam()
	self._name.text = self._animalMo.name
	self._times.text = string.format(lang("petzoo_matchtimes_remain"), self._animalMo.restMatchTimes)

	self._animalMo:refreshAllGeneView(self._specialView)

	self._animalShow, self._avatar = self._animalMo:showAnimalAvatar(self._animalIcon, 240, 256, 0.56, 0.45)

	GlobalDispatcher:addListener(GlobalNotify.OnZooNotifyPairRefuse, self._onZooInviteRefused, self)

	self._canPairList = FriendModel.instance:getGroupDatas(GameEnum.FriendGroup.Friend)

	goutil.setActive(self._empty, #self._canPairList == 0)
	self._friendView:reloadData(self._canPairList)
end

function ZooinvitepairView:onExit()
	ZooinvitepairView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnZooNotifyPairRefuse, self._onZooInviteRefused, self)
end

function ZooinvitepairView:onExitFinished()
	self._refusedFriends = nil

	ZooinvitepairView.super.onExitFinished(self)
	self._friendView:getView():Travel(self._clearFriendCell, self)
	self._friendView:dispose()
	self._avatar:destroy()
	self._animalShow:clear()
end

function ZooinvitepairView:_updateFriendCell(view, cell, data, tag)
	local nameTxt = goutil.findChildTextComponent(cell.gameObject, "name")
	local head = goutil.findChild(cell.gameObject, "head")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local tip = goutil.findChildTextComponent(cell.gameObject, "tip")

	btn:RemoveClickListener()

	nameTxt.text = data._name

	HeadItemController.instance:setHeadCell(head, data.headIconId, data.headFrameId, data.vipLv)

	local pairTimes = self._animalMo.restMatchTimes

	uGuiUtil.setGoGrayState(btn.gameObject, pairTimes == 0)
	btn:AddClickListener(function()
		if pairTimes == 0 then
			FloatWordMgr.instance:show(lang("petzoo_match_notimes"))
		elseif data:getIsOnline() then
			ZooMatchController.instance:sendPM_ZooInviteBuddyMatchReq(data:GetId(), self._animalMo.id)
		else
			FloatWordMgr.instance:show(lang("petzoo_match_friend_offline"))
		end
	end)

	tip.text = self._refusedFriends and self._refusedFriends[data:GetId()] and lang("petzoo_match_invite_hasrefused") or ""
end

function ZooinvitepairView:_clearFriendCell(cell)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local head = goutil.findChild(cell.gameObject, "head")

	btn:RemoveClickListener()
	HeadItemController.instance:resetHeadCell(head)
end

function ZooinvitepairView:_updateGeneCell(view, cell, data)
	local component = ItemGene.AddOnce(cell.gameObject)

	component:setData(data)
end

function ZooinvitepairView:_onZooInviteRefused(friendId)
	self._refusedFriends = self._refusedFriends or {}
	self._refusedFriends[friendId] = true

	self._friendView:refresh()
end

return ZooinvitepairView
