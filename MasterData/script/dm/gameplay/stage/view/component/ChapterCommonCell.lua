-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stage/view/component/ChapterCommonCell.lua

ChapterCommonCell = class("ChapterCommonCell", DisposableObject, _M)

local kImageBgPosition = {
	{
		cc.p(221, 157),
		cc.p(80, 268),
		cc.p(398, 207),
		cc.p(398, 199.5)
	},
	{
		cc.p(167, 237),
		cc.p(182, 33),
		cc.p(233, 345),
		cc.p(233, 337)
	},
	{
		cc.p(230, 86),
		cc.p(18, 211),
		cc.p(398, 144),
		cc.p(398, 136)
	},
	{
		cc.p(343, 135),
		cc.p(452, 238),
		cc.p(540, 182),
		cc.p(540, 174)
	},
	{
		cc.p(246, 300),
		cc.p(250, 35),
		cc.p(310, 94),
		cc.p(310, 86)
	},
	{
		cc.p(230, 153),
		cc.p(325, 281),
		cc.p(387, 227),
		cc.p(387, 219)
	},
	{
		cc.p(298, 121),
		cc.p(447, 21),
		cc.p(493, 167),
		cc.p(493, 159)
	},
	{
		cc.p(148, 221),
		cc.p(13, 486),
		cc.p(216, 417),
		cc.p(216, 409)
	},
	{
		cc.p(275, 115),
		cc.p(423, 216),
		cc.p(474, 166),
		cc.p(474, 158)
	},
	{
		cc.p(257, 140),
		cc.p(18, 283),
		cc.p(420, 216),
		cc.p(420, 208)
	}
}
local kImageBoxPath = "asset/ui/chapter/"

function ChapterCommonCell:initialize(info)
	super.initialize(self)

	local resFile = "asset/ui/BlockCell.csb"

	self._view = cc.CSLoader:createNode(resFile)
	self._mediator = info.mediator

	self:setupView()
end

function ChapterCommonCell:dispose()
	super.dispose()
end

function ChapterCommonCell:getView()
	return self._view
end

function ChapterCommonCell:setupView()
	self:initWigetInfo()
end

function ChapterCommonCell:initWigetInfo()
	self._main = self:getView():getChildByName("main")
	self._bgKuang = self._main:getChildByName("bg_kuang")
	self._bg = self._main:getChildByName("bg")
	self._chapter = self._main:getChildByName("Chapter")
	self._chapterNum = self._chapter:getChildByName("number")
	self._limit1 = self._main:getChildByName("limit1")
	self._limit2 = self._main:getChildByName("limit2")

	self._bgKuang:ignoreContentAdaptWithSize(true)
	self._bg:ignoreContentAdaptWithSize(true)
	self._bgKuang:setSwallowTouches(false)
end

function ChapterCommonCell:updatePos(index)
	local enumType = index % 10

	if enumType == 0 then
		enumType = 10
	end

	local mapPosition = kImageBgPosition[enumType]
	local imgBoxPath = kImageBoxPath .. "BlockChapter" .. tostring(enumType) .. "_1.png"

	self._bgKuang:loadTexture(imgBoxPath)
	self._main:setContentSize(self._bgKuang:getContentSize())
	self._bg:setPosition(mapPosition[1])
	self._chapter:setPosition(mapPosition[2])
	self._limit1:setPosition(mapPosition[3])
	self._limit2:setPosition(mapPosition[4])
end

function ChapterCommonCell:refreshData(mapIndex, stageType, callback)
	self._bg:setTag(mapIndex)

	self._mapId = self._mediator:getStageSystem():index2MapId(mapIndex, stageType)

	local chapterConfig = self._mediator:getStageSystem():getMapConfigByIndex(mapIndex, stageType)
	local mapInfo = self._mediator:getStageSystem():getMapByIndex(mapIndex, stageType)

	self._unlock = mapInfo:isUnlock()

	self._chapter:setString(Strings:get("Common_Stage_CHARTER", {
		num = ""
	}))
	self._chapterNum:setString(mapIndex)
	self._bg:loadTexture("asset/scene/" .. chapterConfig.ButtonIcon)
	self._limit1:setString(mapInfo:getCurrentStarCount())
	self._limit2:setString("/" .. mapInfo:getTotalStarCount())
	self._bgKuang:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			local beganPos = sender:getTouchBeganPosition()
			local endPos = sender:getTouchEndPosition()

			if math.abs(beganPos.x - endPos.x) < 30 and math.abs(beganPos.y - endPos.y) < 30 then
				if self._unlock == true then
					AudioEngine:getInstance():playEffect("Se_Click_Charpter", false)

					local callfunc = cc.CallFunc:create(function()
						local maskImage = self._view:getChildByName("ImageLight")
						local fade = cc.FadeIn:create(0.2)
						local func = cc.CallFunc:create(function()
							maskImage:setOpacity(0)
							callback(mapIndex)
						end)
						local seq = cc.Sequence:create(fade, func)

						maskImage:runAction(seq)
					end)

					self._main:runAction(callfunc)
				else
					self._mediator:dispatch(ShowTipEvent({
						duration = 0.2,
						tip = Strings:find("Lock1")
					}))
				end
			end
		end
	end)
end
