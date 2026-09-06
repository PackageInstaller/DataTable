-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/view/DreampainterRankView.lua

module("logic.extensions.dreampainter.view.DreampainterRankView", package.seeall)

local DreampainterRankView = class("DreampainterRankView", DreampaintertuweiView)

function DreampainterRankView:ctor()
	DreampainterRankView.super.ctor(self)
end

function DreampainterRankView:unbindEvents()
	DreampainterRankView.super.unbindEvents(self)
end

function DreampainterRankView:bindEvents()
	DreampainterRankView.super.bindEvents(self)
end

function DreampainterRankView:buildUI()
	DreampainterRankView.super.buildUI(self)
end

function DreampainterRankView:onExit()
	DreampainterRankView.super.onExit(self)
end

function DreampainterRankView:onEnter()
	DreampainterRankView.super.onEnter(self)
end

function DreampainterRankView:_updateCell(cell, info)
	local img = goutil.findChild(cell, "img")
	local btnVote = goutil.findChild(cell, "btnVote")
	local tag = goutil.findChild(cell, "tag")
	local txtTag = goutil.findChildTextComponent(cell, "tag/txt")
	local txtCount = goutil.findChildTextComponent(cell, "txtCount")
	local txtPicName = goutil.findChildTextComponent(cell, "txtPicName")
	local txtUserName = goutil.findChildTextComponent(cell, "txtUserName")

	GameUtil.SetActive(tag, false)

	txtTag.text = ""

	for i, v in ipairs(self._ranks) do
		if v.workId == info.workId then
			local cfg = DreamPainterConfig.instance:getDreamPainterPrizeByValue(self._activityId, i)

			if cfg and not string.nilorempty(cfg.desc) then
				GameUtil.SetActive(tag, true)

				txtTag.text = cfg.desc or ""

				if i == 1 then
					GameUtil.setUIImageSpriteIdx(tag, 0)

					break
				end

				GameUtil.setUIImageSpriteIdx(tag, 1)
			end

			break
		end
	end

	local cfg = DreamPainterConfig.instance:getWorksCfgById(self._activityId, info.workId) or {}

	txtCount.text = info.value
	txtUserName.text = info.userName
	txtPicName.text = cfg.name or ""

	uGuiUtil.setSpriteToImage(img.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("dreampainter", cfg.imgUrl))
	GameUtil.addClickHandler(btnVote, function()
		DreamPainterController.instance:sendPM_DreamPainterVoteReq(self._activityId, self._curPhaseId, info.workId)
	end)
	GameUtil.addClickHandler(img, function()
		UIStateManager.instance:push(ViewName.DreampaintershowView, self._activityId, self._curPhaseId, self._works, info)
	end)
end

return DreampainterRankView
