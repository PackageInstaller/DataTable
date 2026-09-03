-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mail/view/mailComponent/MailCell.lua

MailCell = class("MailCell", DisposableObject, _M)

MailCell:has("_mediator", {
	is = "r"
})

local function clipStrWithByteSize(clipStr, byteSize)
	local length = utf8.len(clipStr)
	local _tab = {}
	local limitLength = 0

	for i = 1, length do
		local str = utf8.sub(clipStr, i, i)
		local i = string.len(str)

		if i == 1 then
			i = 1.5
		end

		if byteSize >= limitLength + i then
			limitLength = limitLength + i
			_tab[#_tab + 1] = str
		else
			_tab[#_tab + 1] = "..."

			break
		end
	end

	return table.concat(_tab)
end

local kPicMailType = {
	"mai_bg_yj02.png",
	"mai_bg_yj01.png"
}
local kPicMailIcon = {
	"mail_img_01.png",
	"mail_img_02.png",
	"mail_img_03.png"
}

function MailCell:initialize(info)
	super.initialize(self)

	local resFile = "asset/ui/mailCell.csb"

	self._view = cc.CSLoader:createNode(resFile)
	self._mediator = info.mediator

	self:setProperty()
	self:setupView()
end

function MailCell:dispose()
	super.dispose()
end

function MailCell:getView()
	return self._view
end

function MailCell:setProperty()
	return
end

function MailCell:setupView()
	self:initWidgetInfo()
end

function MailCell:initWidgetInfo()
	self.state = 1
	self._imgMail = self:getView():getChildByFullName("mail_cell_bg")
	self._imgMark = self:getView():getChildByName("img_mark")
	self._title = self:getView():getChildByFullName("label_title")
	self._sender = self:getView():getChildByName("label_sender")
	self._time = self:getView():getChildByFullName("Text_time")
	self._isNew = self:getView():getChildByName("Image_new")
	self._imageIcon = self:getView():getChildByName("Image_icon")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		local new = self:getView():getChildByName("Image_new")
		local TextNew = new:getChildByName("Text_new")

		new:setContentSize(cc.size(TextNew:getContentSize().width + 13, 32))
	end
end

function MailCell:refreshData(idx, isSelect)
	local mailInfo = self._mediator._mailSystem:getMailByIndex(idx)

	if mailInfo:getIsRead() ~= true then
		self._isNew:setVisible(true)
	else
		self._isNew:setVisible(false)
	end

	self.state = mailInfo:isItemMail() and (mailInfo:isReceive() and 2 or 1) or mailInfo:getIsRead() == true and 2 or 3

	self._imageIcon:loadTexture(kPicMailIcon[self.state], ccui.TextureResType.plistType)
	self._imgMail:loadTexture(kPicMailType[1], ccui.TextureResType.plistType)

	local titleStr = Strings:get(mailInfo:getTitle())

	self._title:setString(titleStr)

	local labelSize = self._title:getContentSize()

	if labelSize.width > 164 then
		local str = clipStrWithByteSize(titleStr, 24)

		self._title:setString(str)
	end

	local senderStr = Strings:get(mailInfo:getSource())

	self._sender:setString(senderStr)

	local labelSize = self._sender:getContentSize()

	if labelSize.width > 99 then
		local str = clipStrWithByteSize(senderStr, 15)

		self._sender:setString(str)
	end

	local mailDate = TimeUtil:localDate("*t", mailInfo:getSendDate())
	local dateStr = string.format("%d.%d.%d", mailDate.year, mailDate.month, mailDate.day)

	self._time:setString(dateStr)

	if isSelect then
		self:readMail()
	end
end

function MailCell:readMail()
	self._isNew:setVisible(false)

	if self.state == 3 then
		self.state = 2

		self._imageIcon:loadTexture(kPicMailIcon[self.state], ccui.TextureResType.plistType)
	end

	self:setSelectedState(true)
	self._imgMark:setVisible(false)
end

function MailCell:setSelectedState(isSelected)
	local flg

	self._imgMail:loadTexture(kPicMailType[isSelected == true and 2 or 1], ccui.TextureResType.plistType)

	local iconBg = self:getView():getChildByName("icon_imagebg")
end
