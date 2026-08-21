-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\RoleInfoPanelMixin.lua

local HeadHelper = require("UI/RoleInfo/HeadHelper")
local RentTaskUtils = require("UI/RentTask/RentTaskUtils")
local ResColor = require("ClientData/ResColor")
local RoleInfoPanelMixin = {}

function RoleInfoPanelMixin:ctorMixin()
	self:initUIMixin()
end

function RoleInfoPanelMixin:initUIMixin(...)
	self.imgHead = UIControls.Image(self, "InforPanel/BtnHead/Mask/IconPlayer")
	self.imgHeadBg = UIControls.Image(self, "InforPanel/BtnHead/Bg")
	self.imgHeadFrame = UIControls.Image(self, "InforPanel/BtnHead/IconPlayerHeadFrame")
	self.txtLv = UIControls.Label(self, "InforPanel/BtnHead/TextLv")
	self.txtPower = UIControls.Label(self, "InforPanel/TextPower/Text")
	self.txtPosition = UIControls.Label(self, "InforPanel/TextPosition")
	self.imgSex = UIControls.Image(self, "InforPanel/BtnSex/IconSex")
	self.txtName = UIControls.Label(self, "InforPanel/BtnName/TextName")
	self.txtSign = UIControls.Label(self, "InforPanel/BtnSign/TextSign")
	self.txtServer = UIControls.Label(self, "InforPanel/DetailPanel/TextServer/Text")
	self.imgServer = UIControls.Image(self, "InforPanel/DetailPanel/TextServer/Text/IconServer")
	self.btnGuild = UIControls.Button(self, "InforPanel/DetailPanel/BtnGuild")

	self.btnGuild:addEventClick(self.onBtnGuildClick)

	self.txtGuild = UIControls.Label(self, "InforPanel/DetailPanel/BtnGuild/TextName")
	self.imgSearch = UIControls.Image(self, "InforPanel/DetailPanel/BtnGuild/TextName/IconCheck")
	self.panelVip = UIControls.PanelPlayerVip(self, "InforPanel/VIPPanel")
	self.btnClickThrough = UIControls.Button(self, "UIClickThrough")

	self.btnClickThrough:addEventClick(self.onBtnClickThroughClick)

	self.panelCircleInfo = UIControls.Panel(self, "CirclePanel")
	self.imgCircle = UIControls.Image(self, "CirclePanel/IconCircle")
	self.txtCircleName = UIControls.Label(self, "CirclePanel/TextName")
	self.txtCircleId = UIControls.Label(self, "CirclePanel/Bg/IDPanel/TextID")
	self.txtCircleLevel = UIControls.Label(self, "CirclePanel/Bg/LVPanel/TextLV")
	self.txtCircleActive = UIControls.Label(self, "CirclePanel/Bg/ActivePanel/TextNum")
	self.txtCircleNum = UIControls.Label(self, "CirclePanel/Bg/NumPanel/TextNum")
	self.btnCircleRequest = UIControls.Button(self, "CirclePanel/BtnRequest")

	self.btnCircleRequest:addEventClick(self.onBtnCircleRequestClick)

	self.txtRequestName = UIControls.Label(self, "CirclePanel/BtnRequest/Text")
	self.btnHouseVisit = UIControls.Button(self, "InforPanel/DetailPanel/BtnVisit", "TextName")

	self.btnHouseVisit:addEventClick(self.onBtnHouseVisitClick)

	self.panelTaskNum = UIControls.Panel(self, "InforPanel/CaseTaskNum")
	self.txtTaskNum = UIControls.Label(self, "InforPanel/CaseTaskNum/TextNum")
	self.cardHeros = {}

	for i = 1, 5 do
		local newGrid = UIControls.HeroCardChild(self, "InforPanel/CardList/Content", "System/Hero/GridHeroCard")

		newGrid:setVisible(false)

		newGrid.mIndex = i
		newGrid.imgSkinFlag = UIControls.Image(self, "InforPanel/CardList/HeroSkinCornerPanel/Corner" .. i)

		table.insert(self.cardHeros, newGrid)
	end
end

function RoleInfoPanelMixin:setHeroCellClickCallBack(callBack)
	for i, cell in ipairs(self.cardHeros) do
		cell:setSelectCallback(callBack)
	end
end

function RoleInfoPanelMixin:setRoleInfoMixin(roleInfo, orderCell)
	self.roleInfo = roleInfo
	self.openId = roleInfo.openId
	self.commInfo = self.roleInfo.commInfo

	self:refreshMyHeros()
	self:_setCommInfo(roleInfo.commInfo)
	self:_setHeroInfo(roleInfo.heroInfo)

	local baseOrder = 0

	self.orderCell = orderCell

	if orderCell and orderCell.mWindow then
		baseOrder = orderCell.mWindow:getOrder()
	end

	self:setOrder(baseOrder + 5)
	self:setVisible(true)
	self:refreshHeroShow(self.heros)
end

function RoleInfoPanelMixin:_setHeroInfo(info)
	return
end

function RoleInfoPanelMixin:_setCommInfo(commInfo)
	self.txtName:setText(commInfo.name)

	if commInfo.gender == Const.GENDER_MAN then
		self.imgSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.imgSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end

	if RegionUtils.isJP() then
		self.imgSex:setVisible(false)
	end

	self.panelVip:setData(commInfo.vip, commInfo.vip_hide)
	self.txtServer:setText(commInfo.serverName or "")

	if commInfo.sameServer then
		self.imgServer:setVisible(false)
	else
		self.imgServer:setVisible(true)
	end

	self.imgServer:setVisible(false)
	HeadHelper.setHeadIcon(self.imgHead, commInfo.head, self.commInfo.uid)
	HeadHelper.setHeadFrame(self.imgHeadFrame, commInfo.headFrameId, commInfo.head_frame_end_time)
	self.txtLv:setText(string.format(Lang.get(30171), commInfo.level or 0))

	if self.roleInfo.signature ~= "" then
		self.txtSign:setText(self.roleInfo.signature)
		self.txtSign:setFontColor(ResColor.WHITE)
	end

	self.txtPower:setText(self.roleInfo.power)
	self.txtPosition:setText(Lang.get(1556))

	if self.roleInfo:getGuildName() == nil or self.roleInfo:getGuildName() == "" then
		self.txtGuild:setText(Lang.get(30754))
		self.imgSearch:setVisible(false)
		self.btnGuild:setEnable(false)
	else
		self.txtGuild:setText(self.roleInfo:getGuildName())
		self.imgSearch:setVisible(true)
		self.btnGuild:setEnable(true)
	end

	local favorNum = self.roleInfo.houseFavor or 0

	if self.commInfo.uid == CurAvatar.uid then
		local favorInfo = CurAvatar:getFavorInfo()

		if favorInfo then
			favorNum = favorInfo.favoredNum
		end
	end

	if self.commInfo.help_cnt then
		local count = self.commInfo.help_cnt

		if commInfo.uid == CurAvatar.uid then
			count = RentTaskUtils.getTotalHelpCount()
		end

		self.panelTaskNum:setVisible(count > 0)
		self.txtTaskNum:setText(count)
	else
		self.panelTaskNum:setVisible(false)
	end

	self.btnHouseVisit:setText(favorNum)
	self:setCircleData()
end

function RoleInfoPanelMixin:refreshMyHeros(...)
	self.heros = {}

	for i, hero in ipairs(self.roleInfo.heros) do
		table.insert(self.heros, hero)
	end
end

function RoleInfoPanelMixin:refreshHeroShow(heros)
	heros = heros or self.roleInfo.heros

	local count = math.min(#heros, #self.cardHeros)

	for i = 1, count do
		local cell = self.cardHeros[i]

		cell:setHero(heros[i])
		cell:setVisible(true)

		if heros[i]:getSkinQuality() == Const.HERO_SKIN_QUALITY_COLLECTOR then
			cell.imgSkinFlag:setImage("Atlas/HeroAtlas/HeroSkinCornerAtlas", "HeroSkinCornerMvp")
			cell.imgSkinFlag:setVisible(true)
		else
			cell.imgSkinFlag:setVisible(false)
		end
	end

	for i = count + 1, #self.cardHeros do
		self.cardHeros[i]:setVisible(false)
		self.cardHeros[i].imgSkinFlag:setVisible(false)
	end

	if self.checkEmpty then
		self:checkEmpty(count)
	end
end

function RoleInfoPanelMixin:isInCircle(...)
	if self.roleInfo:getGuildName() == nil or self.roleInfo:getGuildName() == "" then
		return false
	end

	return true
end

function RoleInfoPanelMixin:onBtnGuildClick(...)
	if not self:isInCircle() then
		-- block empty
	else
		local data = CurAvatar:tryGetCircleDetailInfoByName(self.roleInfo:getGuildName())

		if data then
			self:setCircleData(data)
		end
	end
end

function RoleInfoPanelMixin:setCircleData(circle)
	if self.circle == nil and circle == nil then
		return
	end

	self.circle = self.circle or circle

	self.btnClickThrough:setVisible(true)
	self.panelCircleInfo:setVisible(true)
	self.txtCircleName:setText(self.circle.name)
	self.txtCircleNum:setText(self.circle.memberCount .. "/" .. self.circle:getCircleMaxMemberCount())
	self.txtCircleActive:setText(self.circle.weekExp)
	self.txtCircleLevel:setText(self.circle.level)
	self.txtCircleId:setText(self.circle.gid)

	local spriteInfo = self.circle:getCircleHeadPath()

	if spriteInfo then
		self.imgCircle:setImage(spriteInfo[1], spriteInfo[2])
	end

	if CurAvatar:isInCircle() then
		self.btnCircleRequest:setVisible(false)
	else
		self.beApplyed = CurAvatar:isCircleApplyed(self.circle.gid)

		local txtBtnApply = self.beApplyed and Lang.get(30174) or Lang.get(774)

		self.txtRequestName:setText(txtBtnApply)
		self.btnCircleRequest:setEnable(not self.beApplyed)
	end
end

function RoleInfoPanelMixin:onBtnClickThroughClick(...)
	self.panelCircleInfo:setVisible(false)
	self.btnClickThrough:setVisible(false)
end

function RoleInfoPanelMixin:onBtnCircleRequestClick(...)
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_CIRCLE) then
		local unlockDesc = ConditionLimitManager.getLimitUnlockDesc(Const.CONDITION_LIMIT_CIRCLE)
		local msg = string.format(Lang.get(30158), unlockDesc)

		MsgManager.notice(msg)

		return
	end

	if self.circle.memberCount == self.circle:getCircleMaxMemberCount() then
		MsgManager.clientNotice(233)

		return
	end

	if self.beApplyed then
		MsgManager.clientNotice(218)
	elseif CurAvatar:isEnterCircleInCD() and self.circle.isAutoPass == 1 then
		MsgManager.clientNotice(202)
	else
		RPC.clanJoin(self.circle.gid)
	end
end

function RoleInfoPanelMixin:onBtnHouseVisitClick(...)
	local result = CurAvatar:checkHouseVisitReq(self.commInfo.uid)

	if result then
		self:setVisible(false)
	end
end

return RoleInfoPanelMixin
