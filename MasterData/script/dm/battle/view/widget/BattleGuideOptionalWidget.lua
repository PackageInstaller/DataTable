-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleGuideOptionalWidget.lua

BattleGuideOptionalWidget = class("BattleGuideOptionalWidget", BaseWidget)

function BattleGuideOptionalWidget:initialize(view, args, callback)
	super.initialize(self, view)

	self._callback = callback
	self._data = args
end

function BattleGuideOptionalWidget:dispose()
	self:getView():removeFromParent(true)
	super.dispose(self)
end

function BattleGuideOptionalWidget:setupView(data)
	local targetNode = data.targetNode
	local targetNextNode = data.targetNextNode
	local targetSize = targetNode:getContentSize()
	local targetNodeAP = targetNode:getAnchorPoint()

	if not data.offset then
		local offset = cc.p(0, 0)
		local rotation = data.rotation
		local arrowOffset = data.arrowOffset
		local pt = cc.p(targetNode:getPositionX() + offset.x, targetNode:getPositionY() + offset.y)
		local centerPt = cc.p(pt.x + targetSize.width * (0.5 - targetNodeAP.x), pt.y + targetSize.height * (0.5 - targetNodeAP.y))
		local targetPt = targetNode:getParent():convertToWorldSpace(centerPt)
		local winSize = cc.Director:getInstance():getVisibleSize()
		local renderNode = cc.Node:create()

		renderNode:setContentSize(winSize)

		local beganPos = cc.p(targetPt.x + arrowOffset.x, targetPt.y + arrowOffset.y)
		local targetNextSize = targetNextNode:getContentSize()
		local targetNextNodeAP = targetNextNode:getAnchorPoint()

		if not data.nextOffset then
			local nextOffset = cc.p(0, 0)
			local nextPt = cc.p(targetNextNode:getPositionX() + nextOffset.x, targetNextNode:getPositionY() + nextOffset.y)
			local centerNextPt = cc.p(nextPt.x + targetNextSize.width * (0.5 - targetNextNodeAP.x), nextPt.y + targetNextSize.height * (0.5 - targetNextNodeAP.y))
			local targetNextPt = targetNextNode:getParent():convertToWorldSpace(centerNextPt)
			local guideWidget = GuideDrag:new({
				beginPos = beganPos,
				endPos = targetNextPt
			})
			local guideView = guideWidget:getView()

			guideView:addTo(renderNode, 1000)
			guideView:setPosition(cc.p(targetPt.x + arrowOffset.x, targetPt.y + arrowOffset.y))
			guideView:setRotation(rotation)

			if data.text and data.text ~= "" then
				if not data.textRefpt then
					local guideText = GuideText:new(data)
					local guideTextView = guideText:getView()

					guideTextView:addTo(renderNode, 1000)
				end
			end

			renderNode:addTo(self:getView())
		end
	end
end
