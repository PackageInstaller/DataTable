-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterEmblemQualityUpMediator.lua

MasterEmblemQualityUpMediator = class("MasterEmblemQualityUpMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {}
local kDescPosX = {
	{
		515
	},
	{
		373,
		633
	},
	{
		295,
		515,
		735
	}
}

function MasterEmblemQualityUpMediator:initialize()
	super.initialize(self)
end

function MasterEmblemQualityUpMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MasterEmblemQualityUpMediator:userInject()
	self._masterSystem = self:getInjector():getInstance(DevelopSystem):getMasterSystem()
end

function MasterEmblemQualityUpMediator:enterWithData(data)
	self._curSelectEmblem = data.curSelectEmblem
	self._oldQualityEmblemQualityId = data.oldQualityEmblemQualityId

	self:setupView()
end

function MasterEmblemQualityUpMediator:setupView()
	self._upQualitySuc = self:getView():getChildByFullName("qualityUpSuc")
	self._nameBg = self._upQualitySuc:getChildByFullName("bg2")

	self._nameBg:setLocalZOrder(2)
	self._nameBg:getChildByFullName("old"):setString(self:getEmblemNameById(self._oldQualityEmblemQualityId))
	self._nameBg:getChildByFullName("old"):setTextColor(GameStyle:getColor(self:getEmblemColorByQualityId(self._oldQualityEmblemQualityId)))
	self._nameBg:getChildByFullName("new"):setString(self._curSelectEmblem:getQualityName())
	self._nameBg:getChildByFullName("new"):setTextColor(GameStyle:getColor(self._curSelectEmblem._showQuality))

	if self._upQualitySuc:getChildByFullName("FileNode_1.levellabel") then
		self._upQualitySuc:getChildByFullName("FileNode_1.levellabel"):setVisible(false)
	end

	local curattr, nextattr = self._curSelectEmblem:getEmblemQualityGrowUpAttrById(self._oldQualityEmblemQualityId)
	local difflist = {}

	for i = 1, 3 do
		self._upQualitySuc:getChildByFullName("info_" .. i):setVisible(false)
		self._upQualitySuc:getChildByFullName("info_" .. i):setLocalZOrder(2)
	end

	local count = 0
	local attData = {}

	for k, v in pairs(curattr) do
		count = count + 1
		difflist[count] = v
		attData[#attData + 1] = k
	end

	for k, v in pairs(nextattr) do
		count = count + 1
		difflist[count] = v
	end

	local showCount = 0

	for i = 1, count do
		local indexb = count - i + 1
		local indexj = math.floor(count / 2) - i + 1

		if indexb ~= i and indexj > 0 then
			local dif = ""

			if type(difflist[indexb]) == "string" and type(difflist[indexj]) == "string" then
				local numA = tonumber(string.split(difflist[indexb], "%")[1])
				local numB = tonumber(string.split(difflist[indexj], "%")[1])

				dif = numA - numB .. "%"
			else
				dif = difflist[indexb] - difflist[indexj]
			end

			showCount = showCount + 1

			self._upQualitySuc:getChildByFullName("info_" .. i):setVisible(true)
			self._upQualitySuc:getChildByFullName("info_" .. i .. ".text"):setString(difflist[indexj])

			local name = AttributeCategory:getAttName(attData[indexj])

			self._upQualitySuc:getChildByFullName("info_" .. i .. ".name"):setString(name)
			self._upQualitySuc:getChildByFullName("info_" .. i .. ".Text_16"):setString("+" .. dif)
			self._upQualitySuc:getChildByFullName("info_" .. i .. ".image"):loadTexture(AttrTypeImage[attData[indexj]] or AttrTypeImage.SPEED, ccui.TextureResType.plistType)
			GameStyle:setCommonOutlineEffect(self._upQualitySuc:getChildByFullName("info_" .. i .. ".name"))
			GameStyle:setCommonOutlineEffect(self._upQualitySuc:getChildByFullName("info_" .. i .. ".text"), 147.89999999999998)
		end
	end

	local pos = kDescPosX[showCount]

	for i = 1, showCount do
		self._upQualitySuc:getChildByFullName("info_" .. i):setPositionX(pos[i])
	end

	self:showQualityAni()
end

function MasterEmblemQualityUpMediator:getEmblemNameById()
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._oldQualityEmblemQualityId)

	if qualityconfig.QualityLevel == 0 then
		return self._curSelectEmblem:getName(qualityconfig.QualityColor)
	else
		return self._curSelectEmblem:getName(qualityconfig.QualityColor) .. "+" .. qualityconfig.QualityLevel
	end
end

function MasterEmblemQualityUpMediator:getEmblemColorByQualityId()
	local qualityconfig = ConfigReader:getRecordById("MasterEmblemQuality", self._oldQualityEmblemQualityId)

	return qualityconfig.QualityColor
end

function MasterEmblemQualityUpMediator:getOldEmblemQualityIcon()
	local showQuality = ConfigReader:getDataByNameIdAndKey("MasterEmblemQuality", self._oldQualityEmblemQualityId, "QualityColor")

	return cc.Sprite:createWithSpriteFrameName(self._curSelectEmblem:getImgName(showQuality))
end

function MasterEmblemQualityUpMediator:getNewEmblemQualityIcon()
	return cc.Sprite:createWithSpriteFrameName(self._curSelectEmblem:getImgName())
end

function MasterEmblemQualityUpMediator:showQualityAni()
	self._animNode = self._upQualitySuc:getChildByFullName("animNode")

	self._animNode:removeAllChildren()

	for i = 1, 3 do
		self._upQualitySuc:getChildByFullName("info_" .. i):setOpacity(0)
	end

	self._nameBg:setOpacity(0)

	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)
	anim:addTo(self._animNode)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local title1 = cc.Label:createWithTTF(Strings:get("Master_LinkSuccess"), CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(Strings:get("UITitle_EN_Shengpinchenggong"), TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)
	anim:addCallbackAtFrame(13, function()
		self._nameBg:fadeIn({
			time = 0.2
		})

		for i = 1, 3 do
			self._upQualitySuc:getChildByFullName("info_" .. i):fadeIn({
				time = 0.2
			})
		end
	end)

	local embmemIconL = self._nameBg:getChildByFullName("old")

	embmemIconL:removeAllChildren()

	local iconL = self:getOldEmblemQualityIcon(self._oldQualityEmblemQualityId)

	iconL:addTo(embmemIconL):posite(embmemIconL:getContentSize().width / 2, 57)
	iconL:setScale(0.64)

	local embmemIconR = self._nameBg:getChildByFullName("new")

	embmemIconR:removeAllChildren()

	local iconR = self:getNewEmblemQualityIcon(self._curSelectEmblem._showQuality)

	iconR:addTo(embmemIconR):posite(embmemIconR:getContentSize().width / 2, 57)
	iconR:setScale(0.64)
end
