-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/setting/view/SetTagsPopMediator.lua

SetTagsPopMediator = class("SetTagsPopMediator", DmPopupViewMediator)

local kBtnHandlers = {
	["main.btn_ok.button"] = {
		clickAudio = "Se_Click_Close_2",
		func = "onClickChoose"
	}
}

function SetTagsPopMediator:initialize()
	super.initialize(self)

	self._allTags = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Player_Tag", "content")
end

function SetTagsPopMediator:dispose()
	super.dispose(self)
end

function SetTagsPopMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("Tip_SetTags"),
		title1 = Strings:get("UITitle_EN_Xiugaibiaoqian"),
		bgSize = {
			width = 690,
			height = 408
		}
	})
	self:bindWidget("main.btn_ok", OneLevelViceButton, {})

	self._main = self:getView():getChildByName("main")
	self._cloneCell = self._main:getChildByName("cell")
	self._tagsView = self._main:getChildByName("tagsView")
end

function SetTagsPopMediator:enterWithData(data)
	self._playerTags = data.playerTags

	local cjson = require("cjson.safe")

	self._chooseTags = (self._playerTags == nil or self._playerTags == "") and {} or cjson.decode(self._playerTags)

	self:initTagsView()

	for _, v in ipairs(self._chooseTags) do
		local _cell = self._tagsView:getChildByName("tag" .. v)

		_cell.isSelect = true

		local image = _cell:getChildByName("Image")

		image:loadTexture("sz_bg_gxbq01.png", ccui.TextureResType.plistType)

		local text = _cell:getChildByName("text")

		text:setTextColor(cc.c3b(255, 255, 255))
	end
end

function SetTagsPopMediator:initTagsView()
	local tagsAmount = #self._allTags
	local tagsView = self._main:getChildByName("tagsView")

	for i = 1, tagsAmount do
		local _cell = self._cloneCell:clone()

		_cell.isSelect = false

		_cell:getChildByName("text"):setString(Strings:get(self._allTags[i]))
		_cell:addTo(tagsView):setName("tag" .. i)

		local row = i % 3

		if row == 0 then
			row = 3
		end

		local line = math.ceil(i / 3)

		_cell:setPosition(cc.p(50 + (row - 1) * 190, -line * 40 + 110))

		local function callFunc()
			self:dealChooseTag(i)
		end

		mapButtonHandlerClick(nil, _cell, {
			ignoreClickAudio = true,
			func = callFunc
		})
	end
end

function SetTagsPopMediator:dealChooseTag(tag)
	local touchCell = self._tagsView:getChildByName("tag" .. tag)
	local image = touchCell:getChildByName("Image")
	local text = touchCell:getChildByName("text")
	local isSelect = touchCell.isSelect

	if isSelect then
		touchCell.isSelect = false

		image:loadTexture("sz_bg_gxbq02.png", ccui.TextureResType.plistType)
		text:setTextColor(cc.c3b(143, 143, 143))
		table.removevalues(self._chooseTags, tag)
	else
		image:loadTexture("sz_bg_gxbq01.png", ccui.TextureResType.plistType)
		text:setTextColor(cc.c3b(255, 255, 255))

		touchCell.isSelect = true

		if #self._chooseTags == 3 then
			local firstTag = self._chooseTags[1]
			local unChooseCell = self._tagsView:getChildByName("tag" .. firstTag)

			unChooseCell.isSelect = false

			local firstImage = unChooseCell:getChildByName("Image")

			firstImage:loadTexture("sz_bg_gxbq02.png", ccui.TextureResType.plistType)

			local firstText = unChooseCell:getChildByName("text")

			firstText:setTextColor(cc.c3b(143, 143, 143))
			table.removevalues(self._chooseTags, firstTag)

			self._chooseTags[3] = tag
		else
			self._chooseTags[#self._chooseTags + 1] = tag
		end
	end
end

function SetTagsPopMediator:onClickClose(sender, eventType)
	self:close()
end

function SetTagsPopMediator:onClickChoose()
	local cjson = require("cjson.safe")
	local chooseTagStr = cjson.encode(self._chooseTags)

	if chooseTagStr ~= self._playerTags then
		self:close({
			playerTags = chooseTagStr
		})
	else
		self:close()
	end
end
