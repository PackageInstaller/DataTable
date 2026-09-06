-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chat/view/ChatEmojiView.lua

module("logic.extensions.chat.view.ChatEmojiView", package.seeall)

local ChatEmojiView = class("ChatEmojiView", TableViewComponent)

function ChatEmojiView:_getPath()
	return {
		cellPath = "bg/tablecell",
		viewPath = "bg/tableview"
	}
end

function ChatEmojiView:unbindEvents()
	ChatEmojiView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._goBtn:RemoveClickListener()
end

function ChatEmojiView:bindEvents()
	ChatEmojiView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._goBtn:AddClickListener(self._onClickGo, self)
end

function ChatEmojiView:onExit()
	ChatEmojiView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ChatEmojiInfo, self._handlePM_GetEmoticonGroupInfoRes, self)
	self._tableview:Travel(function(cell)
		local bigBg = Framework.ImageBigBG.GetFrom(cell.gameObject, "image")

		bigBg:ClearImage()
	end, nil)
	self._btnView:dispose()
	NewChatModel.instance:setExitId(self._curIdx)
end

function ChatEmojiView:buildUI()
	ChatEmojiView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._container = self:getGo("bg")
	self._mask = self:getGo("bg/tableview/mask")
	self._goBtn = self:getBtn("bg/tableview/mask/goBtn")
	self._btnContainer = self:getGo("bg/btnContainer")
	self._btnView = ScrollerList.create(self._btnContainer, self:getGo("bg/btnCell"), GameUtil.handler(self._updateOneBtn, self))
end

function ChatEmojiView:_updateOneBtn(view, cell, cfg)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local imgLock = goutil.findChild(cell, "imgLock")
	local txtName = goutil.findChildTextComponent(cell, "Text")
	local markGif = goutil.findChild(cell, "markGif")

	btn:AddClickListener(function()
		self:_onClickGroup(cfg.id)
	end)

	local unlockIds = NewChatModel.instance:getUnlockedEmoticonGroupIds()

	imgLock:SetActive(not unlockIds[cfg.id])

	txtName.text = cfg.groupName

	markGif:SetActive(cfg.isGif)
end

function ChatEmojiView:_onClickGroup(groupId, isForce)
	local cfg = ChatConfig.instance:getEmojiGroupCfg(groupId)
	local unlockIds = NewChatModel.instance:getUnlockedEmoticonGroupIds()

	if not unlockIds[cfg.id] then
		if cfg.vipLevel > 0 and cfg.vipLevel > VipModel.instance:getCurVipLv() then
			FloatWordMgr.instance:show(string.format("vip达到%d级解锁", cfg.vipLevel))

			return
		elseif not string.nilorempty(cfg.tip) then
			FloatWordMgr.instance:show(lang(cfg.tip))
		end
	end

	goutil.setActive(self._mask, not unlockIds[cfg.id])

	if self._curIdx ~= groupId or isForce then
		self._curIdx = groupId

		self._btnView:refresh()

		self._curViewDatas = ChatConfig.instance:getEmojiCfgsByGroupId(groupId)

		self:reloadData()
	end
end

function ChatEmojiView:onEnter()
	ChatEmojiView.super.onEnter(self)

	local params = self:getOpenParam()
	local x = checknumber(params[1])
	local y = checknumber(params[2])
	local _, _, z = Framework.TransformUtil.GetPos(self._container.transform, 0, 0, 0)

	Framework.TransformUtil.SetPos(self._container.transform, x, y, z)
	GlobalDispatcher:addListener(GlobalNotify.ChatEmojiInfo, self._handlePM_GetEmoticonGroupInfoRes, self)

	self._curIdx = 1

	ChatAgent.instance:sendPM_GetEmoticonGroupInfoReq()
end

function ChatEmojiView:_handlePM_GetEmoticonGroupInfoRes()
	local cfgs = ChatConfig.instance:getEmojiGroupList()
	local sortCfgs = {}
	local unlockIds = NewChatModel.instance:getUnlockedEmoticonGroupIds()

	for i, cfg in ipairs(cfgs) do
		table.insert(sortCfgs, cfg)
	end

	table.sort(sortCfgs, function(a, b)
		if unlockIds[a.id] and not unlockIds[b.id] then
			return true
		elseif not unlockIds[a.id] and unlockIds[b.id] then
			return false
		else
			return a.id > b.id
		end
	end)
	self._btnView:regReloadFinish(function()
		self._btnView:regReloadFinish()
		self:_onClickGroup(NewChatModel.instance:getExitId() or self._curIdx, true)
	end)
	self._btnView:reloadData(sortCfgs)
end

function ChatEmojiView:_updateCell(view, cell, data)
	local img = goutil.findChild(cell.gameObject, "image")
	local btn = Framework.ButtonAdapter.Get(img)
	local groupCfg = ChatConfig.instance:getEmojiGroupCfg(data.groupId)
	local path = string.format("ui/emoji/%s/%s.png", groupCfg.groupPrefix, data.icon)

	uGuiUtil.setSpriteToImage(img, uGuiUtil.SpriteType.BigBg, path)
	btn:AddClickListener(function()
		self:_onClickEmoji(data)
	end)
end

function ChatEmojiView:_onClickEmoji(data)
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.EmojiSelected, data.id)
end

function ChatEmojiView:_onClickClose()
	self:close()
end

function ChatEmojiView:_onClickVip()
	if not self._vipActived then
		local text = string.format("激活<color=#B56A0DFF>VIP%s</color>特权可享受专属特权\n——解锁VIP专属表情包！", self._needVipLevel)

		FloatWordMgr.instance:show(text)
	else
		self:_onClickTab(2)
	end
end

function ChatEmojiView:_onClickBase()
	self:_onClickTab(1)
end

function ChatEmojiView:_onClickGo()
	self:close()

	local cfg = ChatConfig.instance:getEmojiGroupCfg(self._curIdx)

	if not string.nilorempty(cfg.jumpTo) then
		GotoMgr.gotoByString(cfg.jumpTo)
	end
end

return ChatEmojiView
