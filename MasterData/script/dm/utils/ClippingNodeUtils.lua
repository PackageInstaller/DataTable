-- chunkname: @/tmp/or_script/lua_compile/dm/utils/ClippingNodeUtils.lua

module("ClippingNodeUtils", package.seeall)

function transformToClippingNodeByUI(rootNode, alphaThreshold, data)
	alphaThreshold = alphaThreshold or 0.05

	local contentName = "content"
	local stencilName = "stencil"

	if data then
		contentName = data.content or "content"
		stencilName = data.stencil or "stencil"
	end

	local content = rootNode:getChildByName(contentName)
	local stencil = rootNode:getChildByName(stencilName)
	local clipper = cc.ClippingNode:create()

	clipper:setAlphaThreshold(alphaThreshold)
	stencil:retain()
	stencil:removeFromParent()
	clipper:setStencil(stencil)
	stencil:release()
	content:changeParent(clipper)
	rootNode:addChild(clipper)

	return clipper
end

function getClippingNodeByData(data, alphaThreshold)
	alphaThreshold = alphaThreshold or 0.05

	local content = data.content
	local stencil = data.stencil

	if stencil.drawPoint then
		alphaThreshold = 1
	end

	local clipper = cc.ClippingNode:create()

	clipper:setAlphaThreshold(alphaThreshold)
	clipper:setStencil(stencil)
	clipper:addChild(content)

	return clipper
end
