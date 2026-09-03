-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/home/view/DebugShowBustAniUnAwake.lua

DebugShowBustAniUnAwake = class("DebugShowBustAniUnAwake", DmAreaViewMediator)

DebugShowBustAniUnAwake:has("_developSystem", {
	is = "r"
}):injectWith(DevelopSystem)

local kBtnHandlers = {
	["main.Button_19"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickRight"
	},
	["main.Button_20"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickLeft"
	},
	["main.Button_17"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBack"
	},
	["main.Button_21"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickChange"
	},
	["main.Button_20_0"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickPageLeft"
	},
	["main.Button_19_0"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickPageRight"
	}
}

function DebugShowBustAniUnAwake:initialize()
	super.initialize(self)
end

function DebugShowBustAniUnAwake:dispose()
	super.dispose(self)
end

function DebugShowBustAniUnAwake:onRegister()
	super.onRegister(self)

	self._heroSystem = self._developSystem:getHeroSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:initData()
end

function DebugShowBustAniUnAwake:onClickBack()
	self:dismiss()
end

function DebugShowBustAniUnAwake:enterWithData(data)
	self._modelId = data.id
	self._frameId = self._bustFrames[1]
	self._flag = data.flag

	if data.flag == 1 then
		self._index = table.find(self._awakeData, self._modelId)
	end

	if data.flag == 2 then
		self._index = table.find(self._heroData, self._modelId)
	end

	if data.flag == 3 then
		self._index = table.find(self._allData, self._modelId)
	end

	self._pageIndex = 1

	self:initView()
end

local unuse_fid = {
	"bustframe6_4",
	"bustframe4_10",
	"bustframe5_1",
	"bustframe5",
	"bustframe7_3",
	"bustframe19",
	"bustframe20"
}
local diff_fid = {
	"bustframe4_7",
	"bustframe6_6",
	"bustframe18"
}

function DebugShowBustAniUnAwake:initData()
	self._masterData = {}
	self._heroData = {}
	self._awakeData = {}
	self._surface = {}
	self._allData = {}

	local dataTable = ConfigReader:getDataTable("RoleModel")

	for k, v in pairs(dataTable) do
		local picType = v.PicType
		local path = v.Path

		if path and path ~= "" then
			if picType == 1 then
				table.insert(self._masterData, v.Id)
				table.insert(self._allData, v.Id)
			elseif picType == 2 then
				table.insert(self._heroData, v.Id)
				table.insert(self._allData, v.Id)
			elseif picType == 3 then
				table.insert(self._surface, v.Id)
				table.insert(self._allData, v.Id)
			elseif picType == 5 then
				table.insert(self._heroData, v.Id)

				if string.find(v.Id, "_UnAwake") then
					table.insert(self._awakeData, v.Id)
				end

				table.insert(self._allData, v.Id)
			end
		end
	end

	self._bustFrames = {}

	local dataTable = ConfigReader:getDataTable("BustFrame")

	for k, v in pairs(dataTable) do
		local fid = v.Id

		if not table.find(unuse_fid, fid) and not table.find(diff_fid, fid) then
			table.insert(self._bustFrames, v.Id)
		end
	end

	self._zhujueFrames = {
		"bustframe13_3",
		"bustframe13_4",
		"bustframe13_7",
		"bustframe13_8",
		"bustframe13_9",
		"bustframe13_10",
		"bustframe1",
		"bustframe2_2",
		"bustframe4_1",
		"bustframe4_2",
		"bustframe4_3",
		"bustframe4_4",
		"bustframe4_5",
		"bustframe4_9",
		"bustframe6_1",
		"bustframe6_2",
		"bustframe6_3"
	}
	self._huobanframes = {
		"bustframe3",
		"bustframe4_8",
		"bustframe7_1",
		"bustframe7_2",
		"bustframe8",
		"bustframe13_1",
		"bustframe13_2"
	}
	self._huobanAndZhujueFrames = {
		"bustframe10",
		"bustframe11"
	}
	self._noStencialFrames = {
		"bustframe2_1",
		"bustframe6_5",
		"bustframe9",
		"bustframe16",
		"bustframe17",
		"bustframe15",
		"bustframe2_5"
	}
end

function DebugShowBustAniUnAwake:initView()
	self._main = self:getView():getChildByFullName("main")
	self._panel = self._main:getChildByFullName("Panel_36")
	self._editBox = self._main:getChildByFullName("TextField")

	if self._editBox:getDescription() == "TextField" then
		self._editBox:setString("")
	end

	self._editBox:setString(self._modelId)

	self._editBox = convertTextFieldToEditBox(self._editBox, nil, MaskWordType.CHAT)

	self._editBox:onEvent(function(eventName, sender)
		return
	end)
	self:refreshView2()
end

function DebugShowBustAniUnAwake:refreshView2()
	self._panel:removeAllChildren()

	self._hand = nil
	self._heroAwakeFinished = false

	if self._flag == 1 then
		self._modelId = self._awakeData[self._index]

		if self._modelId then
			local view = cc.CSLoader:createNode("asset/ui/StrengthenAwaken.csb")

			view:setScale(0.5)
			view:addTo(self._panel):posite(0, 320)

			local main = view:getChildByFullName("mainpanel")
			local awakeRoleNode = main:getChildByFullName("heropanel")
			local masterIcon = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe9",
				id = self._modelId,
				useAnim = self._heroAwakeFinished
			})

			awakeRoleNode:removeAllChildren()

			local posY = self._heroAwakeFinished and 0 or -100

			masterIcon:addTo(awakeRoleNode):setPosition(0, posY)
			awakeRoleNode:setPositionY(320)
		end

		local editBox = self._main:getChildByFullName("TextField_" .. 1)

		editBox:setString("bustframe9")

		self._modelId = self._awakeData[self._index + 1]

		if self._modelId then
			local view = cc.CSLoader:createNode("asset/ui/StrengthenAwaken.csb")

			view:setScale(0.5)
			view:addTo(self._panel):posite(600, 320)

			local main = view:getChildByFullName("mainpanel")
			local awakeRoleNode = main:getChildByFullName("heropanel")
			local masterIcon = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe9",
				id = self._modelId,
				useAnim = self._heroAwakeFinished
			})

			awakeRoleNode:removeAllChildren()

			local posY = self._heroAwakeFinished and 0 or -100

			masterIcon:addTo(awakeRoleNode):setPosition(0, posY)
			awakeRoleNode:setPositionY(320)
		end

		local editBox = self._main:getChildByFullName("TextField_" .. 1)

		editBox:setString("bustframe9")

		self._modelId = self._awakeData[self._index + 2]

		if self._modelId then
			local view = cc.CSLoader:createNode("asset/ui/StrengthenAwaken.csb")

			view:setScale(0.5)
			view:addTo(self._panel):posite(0, 0)

			local main = view:getChildByFullName("mainpanel")
			local awakeRoleNode = main:getChildByFullName("heropanel")
			local masterIcon = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe9",
				id = self._modelId,
				useAnim = self._heroAwakeFinished
			})

			awakeRoleNode:removeAllChildren()

			local posY = self._heroAwakeFinished and 0 or -100

			masterIcon:addTo(awakeRoleNode):setPosition(0, posY)
			awakeRoleNode:setPositionY(320)
		end

		local editBox = self._main:getChildByFullName("TextField_" .. 1)

		editBox:setString("bustframe9")

		self._modelId = self._awakeData[self._index + 3]

		if self._modelId then
			local view = cc.CSLoader:createNode("asset/ui/StrengthenAwaken.csb")

			view:setScale(0.5)
			view:addTo(self._panel):posite(600, 0)

			local main = view:getChildByFullName("mainpanel")
			local awakeRoleNode = main:getChildByFullName("heropanel")
			local masterIcon = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe9",
				id = self._modelId,
				useAnim = self._heroAwakeFinished
			})

			awakeRoleNode:removeAllChildren()

			local posY = self._heroAwakeFinished and 0 or -100

			masterIcon:addTo(awakeRoleNode):setPosition(0, posY)
			awakeRoleNode:setPositionY(320)
		end

		local editBox = self._main:getChildByFullName("TextField_" .. 1)

		editBox:setString("bustframe9")

		if not self._awakeData[self._index] then
			local str = ""

			str = str .. "   " .. ((not self._awakeData[self._index + 1] or nil) and "") .. "\n"
			str = (str .. "   " .. ((not self._awakeData[self._index + 1] or nil) and "") .. "\n") .. "   " .. (self._awakeData[self._index + 2] or "")
			str = ((str .. "   " .. ((not self._awakeData[self._index + 1] or nil) and "") .. "\n") .. "   " .. (self._awakeData[self._index + 2] or "")) .. "   " .. (self._awakeData[self._index + 3] or "")

			self._editBox:setText(((str .. "   " .. ((not self._awakeData[self._index + 1] or nil) and "") .. "\n") .. "   " .. (self._awakeData[self._index + 2] or "")) .. "   " .. (self._awakeData[self._index + 3] or ""))

			local text_fid = self._main:getChildByFullName("text_page")

			text_fid:setString(self._index .. "/" .. #self._masterData)

			local winSize = cc.Director:getInstance():getWinSize()
			local touchPanel = ccui.Layout:create()

			touchPanel:setAnchorPoint(cc.p(0, 0.5))
			touchPanel:setContentSize(cc.size(1386, 2))
			touchPanel:setBackGroundColorType(1)
			touchPanel:setBackGroundColor(cc.c3b(255, 0, 0))
			touchPanel:setBackGroundColorOpacity(180)
			touchPanel:addTo(self._panel):posite(0, winSize.height / 2)

			local touchPanel = ccui.Layout:create()

			touchPanel:setAnchorPoint(cc.p(0.5, 0))
			touchPanel:setContentSize(cc.size(2, 852))
			touchPanel:setBackGroundColorType(1)
			touchPanel:setBackGroundColor(cc.c3b(255, 0, 0))
			touchPanel:setBackGroundColorOpacity(6180)
			touchPanel:addTo(self._panel):posite(winSize.width / 2, 0)
		end
	end
end

function DebugShowBustAniUnAwake:onClickLeft()
	if self._flag == 1 then
		self._index = self._index - 4
		self._index = math.max(self._index, 1)
		self._modelId = self._awakeData[self._index]
	end

	self:refreshView2()
end

function DebugShowBustAniUnAwake:onClickRight()
	if self._flag == 1 then
		self._index = self._index + 4
		self._index = math.min(self._index, #self._awakeData)
		self._modelId = self._awakeData[self._index]
	end

	self:refreshView2()
end

function DebugShowBustAniUnAwake:onClickPageLeft()
	self._pageIndex = 1

	self:refreshView2()
end

function DebugShowBustAniUnAwake:onClickPageRight()
	self:refreshView2()
end

function DebugShowBustAniUnAwake:onClickChange()
	return
end
