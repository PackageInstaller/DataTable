-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/friend/view/FriendInfoPopMediator.lua

FriendInfoPopMediator = class("FriendInfoPopMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {
	["main.btn_back"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickClose"
	}
}
local constellationAge = {
	120,
	219,
	321,
	420,
	521,
	622,
	723,
	823,
	923,
	1024,
	1123,
	1222
}
local constellation = {
	"Aquarius",
	"Pisces",
	"Aries",
	"Taurus",
	"Gemini",
	"Cancer",
	"Leo",
	"Virgo",
	"Libra",
	"Scorpio",
	"Sagittarius",
	"Capricorn"
}

function FriendInfoPopMediator:initialize()
	super.initialize(self)
end

function FriendInfoPopMediator:dispose()
	super.dispose(self)
end

function FriendInfoPopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function FriendInfoPopMediator:enterWithData(data)
	self._main = self:getView():getChildByName("main")
	self._record = data

	local extraData = {}

	extraData.gender = data.gender
	extraData.birthday = data.birthday
	extraData.city = data.city
	extraData.tags = data.tags
	self._baseData = extraData

	self:initRoleInfo()
	self:initTeamInfo()
	self:initBaseInfo()
end

function FriendInfoPopMediator:initRoleInfo()
	local name = self._main:getChildByFullName("name")
	local group = self._main:getChildByFullName("group_name")
	local combat = self._main:getChildByFullName("fighting_bg.fighting_number")
	local level = self._main:getChildByFullName("level_num")
	local slogan = self._main:getChildByName("slogan")
	local playerIconBg = self._main:getChildByName("icon_top")

	self._masterIconBg = self._main:getChildByFullName("teamInfo.icon_bottom")
	self._image_stencil = self._masterIconBg:getChildByFullName("Image_stencil")

	name:setString(self._record.nickname)

	local clubName = self._record.clubName

	if clubName == nil or clubName == "" then
		clubName = Strings:get("ARENA_NO_RANK")
	end

	group:setString(Strings:get("Resource_SheTuan") .. ":" .. clubName)
	combat:setString(self._record.combat)
	level:setString("Lv." .. self._record.level)
	slogan:setString(self._record.slogan)

	local headIcon = IconFactory:createPlayerIcon({
		clipType = 4,
		id = self._record.headImage,
		size = playerIconBg:getContentSize(),
		headFrameId = self._record.headFrame
	})

	headIcon:addTo(playerIconBg):center(playerIconBg:getContentSize())
end

function FriendInfoPopMediator:initTeamInfo()
	local master = self._record.master

	if master then
		local stencil = self._image_stencil:clone()

		stencil:setVisible(true)

		local roleModel = IconFactory:getRoleModelByKey("MasterBase", master[1])
		local info = {
			iconType = "Bust5",
			id = roleModel,
			stencil = stencil
		}
		local masterIcon = IconFactory:createRoleIconSprite(info)

		self._masterIconBg:addChild(masterIcon)

		local teamBg = self._main:getChildByFullName("teamInfo")
		local text = teamBg:getChildByName("text")

		text:setTextColor(cc.c4b(164, 164, 164, 33.15))
		text:enableOutline(cc.c4b(255, 255, 255, 255), 2)

		local heros = self._record.heroes

		for k, v in pairs(heros) do
			local petBg = teamBg:getChildByName("pet_" .. k)
			local heroInfo = {
				id = v[1],
				level = tonumber(v[2]),
				star = tonumber(v[3]),
				quality = tonumber(v[4])
			}
			local petNode = IconFactory:createHeroSmallIcon(heroInfo, {
				hideStar = true
			})

			petNode:setScale(0.7)
			petNode:addTo(petBg):center(petBg:getContentSize())
		end
	end
end

function FriendInfoPopMediator:initBaseInfo()
	local genderView = self._main:getChildByName("gender")
	local birthdayView = self._main:getChildByName("birthdayImg")
	local areaView = self._main:getChildByName("areaImg")
	local playerBaseData = self._baseData

	if not playerBaseData then
		return
	end

	genderView:ignoreContentAdaptWithSize(true)

	if playerBaseData.gender == 1 then
		genderView:setVisible(true)
		genderView:loadTexture("sz_icon_nan.png", ccui.TextureResType.plistType)
	elseif playerBaseData.gender == 2 then
		genderView:setVisible(true)
		genderView:loadTexture("sz_icon_nv.png", ccui.TextureResType.plistType)
	else
		genderView:setVisible(false)
	end

	if playerBaseData.birthday and playerBaseData.birthday ~= "" then
		birthdayView:setVisible(true)

		local birthdayTab, constellationStr = self:parseTimeStr(playerBaseData.birthday)

		birthdayView:getChildByName("birthday"):setString(tostring(birthdayTab.month) .. Strings:get("Setting_UI_Month") .. tostring(birthdayTab.day) .. Strings:get("Setting_UI_Day") .. " " .. constellationStr)
	else
		birthdayView:setVisible(false)
	end

	if playerBaseData.city and playerBaseData.city ~= "" then
		areaView:setVisible(true)

		local parts = string.split(playerBaseData.city, "-")
		local areaInfo = ConfigReader:getRecordById("PlayerPlace", parts[1])
		local str1 = Strings:get(areaInfo.Provinces)
		local cityInfo = areaInfo.City[tonumber(parts[2])]
		local str2 = Strings:get(cityInfo)

		areaView:getChildByName("area"):setString(str1 .. " " .. str2)
	else
		areaView:setVisible(false)
	end

	if playerBaseData.tags and playerBaseData.tags ~= "" then
		local cjson = require("cjson.safe")
		local playerTags = cjson.decode(playerBaseData.tags)
		local playerTagsArray = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Tag", "content")
		local cloneCell = self:getView():getChildByName("cell")

		for k, v in ipairs(playerTags) do
			local _cell = cloneCell:clone()

			_cell:getChildByName("text"):setString(Strings:get(playerTagsArray[v]))
			_cell:addTo(self._main)
			_cell:setPosition(cc.p(435 + 86 * (k - 1), 306))
		end
	end
end

function FriendInfoPopMediator:parseTimeStr(timeStr)
	local _tab = {}
	local _str
	local strTab = string.split(timeStr, "-")

	_tab.year = tonumber(strTab[1])
	_tab.month = tonumber(strTab[2])
	_tab.day = tonumber(strTab[3])

	local tag = 0
	local _compData = _tab.month * 100 + _tab.day

	for k, v in ipairs(constellationAge) do
		if v <= _compData then
			tag = tag + 1
		end
	end

	if tag == 0 then
		tag = 12
	end

	return _tab, (Strings:get(constellation[tag]))
end

function FriendInfoPopMediator:onClickClose(sender, eventType)
	self:close()
end
