-- chunkname: @modules/logic/partygame/view/carddrop/promotionview/CardDropPromotionView.lua

module("modules.logic.partygame.view.carddrop.promotionview.CardDropPromotionView", package.seeall)

local CardDropPromotionView = class("CardDropPromotionView", BaseView)

CardDropPromotionView.ResultType = {
	Fail = 2,
	Win = 1
}
CardDropPromotionView.PlayerItemAnchor = {
	Win = Vector2(23.7, -9.08),
	Fail = Vector2(0, -50.5)
}
CardDropPromotionView.AnchorDict = {
	[2] = {
		[CardDropPromotionView.ResultType.Win] = {
			Vector2(-260, -294),
			Vector2(260, -294)
		},
		[CardDropPromotionView.ResultType.Fail] = {
			Vector2(-683, -584.84),
			Vector2(683, -584.84)
		}
	},
	[4] = {
		[CardDropPromotionView.ResultType.Win] = {
			Vector2(-554, -294),
			Vector2(-184, -294),
			Vector2(184, -294),
			Vector2(554, -294)
		},
		[CardDropPromotionView.ResultType.Fail] = {
			Vector2(-804, -552),
			Vector2(-517, -607),
			Vector2(517, -607),
			Vector2(804, -552)
		}
	}
}

function CardDropPromotionView.blockEsc()
	return
end

function CardDropPromotionView:onInitView()
	self.goListItem = gohelper.findChild(self.viewGO, "root/list/#go_listitem")

	gohelper.setActive(self.goListItem, false)

	self.interface = PartyGameCSDefine.CardDropInterfaceCs

	NavigateMgr.instance:addEscape(self.viewName, self.blockEsc)
end

local Scale = {
	Fail = 0.8,
	Win = 1
}

function CardDropPromotionView:onOpen()
	AudioMgr.instance:trigger(340136)

	local data = self.viewParam.data
	local scoreList = data.ScoreList
	local count = scoreList.Count

	if not CardDropPromotionView.AnchorDict[count / 2] then
		local anchorDict = CardDropPromotionView.AnchorDict[2]
		local scaleCount = count / 4
		local winCount = 0
		local loseCount = 0

		for i = 0, count - 1 do
			local scoreMo = scoreList[i]
			local index = tonumber(self.interface.GetScoreMoValue(scoreMo, "index"))
			local playerMo = PartyGameModel.instance:getPlayerMoByIndex(index)
			local rank = tonumber(self.interface.GetScoreMoValue(scoreMo, "rank"))
			local isMain = playerMo:isMainPlayer()
			local go = gohelper.cloneInPlace(self.goListItem)

			gohelper.setActive(go, true)

			local win = rank == 1

			if win then
				winCount = winCount + 1

				gohelper.setAsFirstSibling(go)
			else
				loseCount = loseCount + 1

				gohelper.setAsLastSibling(go)
			end

			local playerGo = gohelper.findChild(go, "#player/player")
			local comp = MonoHelper.addNoUpdateLuaComOnceToGo(playerGo, CommonPartyGamePlayerSpineComp)

			comp:initSpine(playerMo.uid)

			local playerItemGo = gohelper.findChild(go, "#player/common_knockoutplayeritem")

			gohelper.setActive(playerItemGo, true)

			if win then
				if not CardDropPromotionView.PlayerItemAnchor.Win then
					local anchor = CardDropPromotionView.PlayerItemAnchor.Fail

					recthelper.setAnchor(playerItemGo.transform, anchor.x, anchor.y)

					local playerItem = CardDropCommonPlayerItem.Create(playerItemGo)

					playerItem:setNameTextByPlayerMo(playerMo)
					playerItem:setArrowActive(isMain)
					playerItem:setImageLightActive(false)
					playerItem:setImageSelfLightActive(false)

					local winSelfGo = gohelper.findChild(go, "#light_self")
					local winGo = gohelper.findChild(go, "#light_win")

					gohelper.setActive(winSelfGo, win and isMain)
					gohelper.setActive(winGo, win and not isMain)

					local animName = win and "happyLoop" or "sad"

					comp:playAnim(animName, true, false)

					if win then
						if not anchorDict[CardDropPromotionView.ResultType.Win] then
							local anchorList = anchorDict[CardDropPromotionView.ResultType.Fail]

							if win then
								if not anchorList[winCount] then
									local anchor = anchorList[loseCount]

									anchor = anchor or anchorList[1]

									if win then
										if not Scale.Win then
											local srcScale = Scale.Fail
											local scale = srcScale
											local tr = playerGo.transform

											recthelper.setAnchor(go.transform, anchor.x, anchor.y)

											if win then
												if winCount <= scaleCount then
													scale = -scale or scale
												end
											else
												scale = loseCount <= scaleCount and -scale or scale
											end

											transformhelper.setLocalScale(tr, scale, srcScale, srcScale)
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function CardDropPromotionView:refreshPlayer()
	return
end

return CardDropPromotionView
