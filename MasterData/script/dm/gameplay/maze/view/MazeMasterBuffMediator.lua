-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeMasterBuffMediator.lua

MazeMasterBuffMediator = class("MazeMasterBuffMediator", DmPopupViewMediator, _M)

MazeMasterBuffMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	["main.checkBtn"] = "onClickBuffChek",
	["main.closebtn"] = "onClickExit"
}

function MazeMasterBuffMediator:initialize()
	super.initialize(self)
end

function MazeMasterBuffMediator:dispose()
	super.dispose(self)
end

function MazeMasterBuffMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MazeMasterBuffMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_BUFF_SUC, self, self.updateViews)
end

function MazeMasterBuffMediator:dispose()
	super.dispose(self)
end

function MazeMasterBuffMediator:enterWithData(data)
	self._data = data

	self:initData()
	self:initView()
end

function MazeMasterBuffMediator:initData()
	local mlv = self._mazeSystem:getSelectMasterLv()

	self._buffId = ""
	self._allBuffData = self._mazeSystem._mazeChapter:getTeamBuff()
	self._curBuffData = self._allBuffData[tostring(mlv)]
end

function MazeMasterBuffMediator:updateViews()
	self:close()
end

function MazeMasterBuffMediator:resetSelect()
	for k, v in pairs(self._cellList) do
		v:getChildByFullName("Image_9"):setVisible(false)
	end
end

function MazeMasterBuffMediator:initView()
	self._main = self:getView():getChildByFullName("main")
	self._cellList = {}

	local attrEff = self._curBuffData.attrEffects
	local conut = 0

	for k, v in pairs(attrEff) do
		local config = ConfigReader:getRecordById("SkillAttrEffect", v)
		local name = Strings:get(config.Name)
		local effectdesc = self:getEffectDesc(config.Id, self._mazeSystem:getSelectMasterLv())
		local cell = self._main:getChildByFullName("buffcell"):clone()

		table.insert(self._cellList, cell)
		cell:setTag(10001 + conut)

		local select = cell:getChildByFullName("Image_9")

		cell:getChildByFullName("name"):setString(name)
		cell:getChildByFullName("effect"):setString(effectdesc)

		local icon = cell:getChildByFullName("bufficon")
		local bufficon = ConfigReader:getDataByNameIdAndKey("SkillAttrEffect", v, "Icon")
		local skillicon = IconFactory:createSkillPic({
			id = bufficon
		})

		skillicon:setPosition(23, 12)
		icon:addChild(skillicon)
		cell:setPosition(30 + conut * 160, 20)
		select:setVisible(count == 0)

		if count == 0 then
			self._buffId = v
		end

		conut = conut + 1

		self._main:getChildByFullName("buffpanel"):addChild(cell)
		cell:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

				self._buffId = v

				self:resetSelect()
				sender:getChildByFullName("Image_9"):setVisible(true)
				print("buffid--->", v)
			end
		end)
		print("名字-->", name, " 效果-->", effectdesc)
	end
end

function MazeMasterBuffMediator:getEffectDesc(effectId, level)
	local effectConfig = ConfigReader:getRecordById("SkillAttrEffect", effectId)
	local effectDesc = effectConfig.EffectDesc
	local descValue = Strings:get(effectDesc)
	local factorMap = ConfigReader:getRecordById("SkillAttrEffect", effectId)
	local t = TextTemplate:new(descValue)
	local funcMap = {
		linear = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1] + (level - 1) * value[2]
		end,
		fixed = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[1]
		end,
		custom = function(value)
			if type(value) ~= "table" then
				return nil
			end

			return value[level]
		end
	}

	return t:stringify(factorMap, funcMap)
end

function MazeMasterBuffMediator:updateViews()
	self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
	self:close()
end

function MazeMasterBuffMediator:createQuestionCell(id)
	return
end

function MazeMasterBuffMediator:createQuestionCheckBtn(id)
	return
end

function MazeMasterBuffMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:close()
	end
end

function MazeMasterBuffMediator:onClickBuffChek(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:checkBuff()
	end
end

function MazeMasterBuffMediator:checkBuff()
	if self._buffId == "" then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("MAZE_BUFF_TIPS")
		}))

		return
	else
		self._mazeSystem:requestMazeSelectMasterBuff(self._mazeSystem._mazeEvent:getConfigId(), self._mazeSystem:getSelectMasterLv(), self._buffId, function(...)
			return
		end)
		self:close()
	end
end
