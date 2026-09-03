-- chunkname: @/tmp/or_script/lua_compile/dm/gameupdate/view/GameUpdateLoadingWidget.lua

require("dm.assets.Strings")

local UpdateLoadingWidget = {}

function UpdateLoadingWidget:new()
	local result = setmetatable({}, {
		__index = self
	})

	result:initialize()

	return result
end

function UpdateLoadingWidget:initialize(view)
	self._view = view
end

function UpdateLoadingWidget:getView()
	return self._view
end

function UpdateLoadingWidget:setupView(view)
	local resFile = "asset/ui/LoadingLayer.csb"
	local node = cc.CSLoader:createNode(resFile)

	node:addTo(view, 10):setName("bottom")
end

function UpdateLoadingWidget:onProgress(task, progress)
	local loadingNode = self:getView():getChildByFullName("bottom.node_pro")
	local loadingBar = loadingNode:getChildByName("loading")

	loadingBar:setPercent(progress * 100)

	local progressNum = loadingNode:getChildByName("textProgress")

	progressNum:setString(string.format("%d", progress * 100))
end

function UpdateLoadingWidget:onError(task, err, level)
	if DEBUG and DEBUG > 0 then
		assert(false, "Loading Error:" .. err)
	elseif level > 1 then
		task:abort()
	else
		task:recoveryFromError()
	end
end

function UpdateLoadingWidget:onCompleted(task)
	return
end

function UpdateLoadingWidget:onAbort(task)
	return
end

local GameUpdateLoadingWidget = setmetatable({
	name = "GameUpdateLoadingWidget"
}, {
	__index = UpdateLoadingWidget,
	__newindex = function(t, k, v)
		if _G.type(v) == "function" then
			local fenv = _G.getfenv(v)

			v = _G.setfenv(v, _G.setmetatable({
				super = UpdateLoadingWidget
			}, {
				__index = fenv,
				__newindex = fenv
			}))
		end

		_G.rawset(t, k, v)
	end
})

function GameUpdateLoadingWidget:initialize()
	local view = ccui.Layout:create()

	view:setContentSize(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height)
	super.initialize(self, view)
end

function GameUpdateLoadingWidget:setupView()
	local view = self:getView()

	super.setupView(self, view)

	local bg = cc.Sprite:create("asset/ui/loading/bg_ld_xyx_02.png")

	bg:addTo(view, -1):center(view:getContentSize())

	local resFile = "asset/ui/gameLoading.csb"
	local node = cc.CSLoader:createNode(resFile)

	node:addTo(view, 9):setName("main"):center(view:getContentSize())

	local bottomPanel = view:getChildByFullName("bottom")

	if bottomPanel then
		local bottomBgImg = bottomPanel:getChildByName("Image_bg")

		bottomBgImg:loadTexture("asset/ui/loading/bg_ld_ho_01.png")
	end
end

local GuideUpdateLoadingWidget = setmetatable({
	name = "GuideUpdateLoadingWidget"
}, {
	__index = UpdateLoadingWidget,
	__newindex = function(t, k, v)
		if _G.type(v) == "function" then
			local fenv = _G.getfenv(v)

			v = _G.setfenv(v, _G.setmetatable({
				super = UpdateLoadingWidget
			}, {
				__index = fenv,
				__newindex = fenv
			}))
		end

		_G.rawset(t, k, v)
	end
})

function GuideUpdateLoadingWidget:initialize()
	local view = ccui.Layout:create()

	view:setContentSize(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height)
	super.initialize(self, view)
end

function GuideUpdateLoadingWidget:setupView()
	local view = self:getView()

	super.setupView(self, view)
end

local NewUpdateLoadingWidget = setmetatable({
	name = "NewUpdateLoadingWidget"
}, {
	__index = UpdateLoadingWidget,
	__newindex = function(t, k, v)
		if _G.type(v) == "function" then
			local fenv = _G.getfenv(v)

			v = _G.setfenv(v, _G.setmetatable({
				super = UpdateLoadingWidget
			}, {
				__index = fenv,
				__newindex = fenv
			}))
		end

		_G.rawset(t, k, v)
	end
})

function NewUpdateLoadingWidget:initialize()
	local view = ccui.Layout:create()

	view:setContentSize(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height)
	super.initialize(self, view)
end

function NewUpdateLoadingWidget:setupView()
	local view = self:getView()
	local resFile = "asset/ui/UpdateLoadingLayer.csb"
	local node = cc.CSLoader:createNode(resFile)

	node:addTo(view, 10):setName("bottom")

	if AdjustUtils then
		AdjustUtils.adjustLayoutUIByRootNode(node)
	end

	self:initProgress()
	self:refreshBg()
end

function NewUpdateLoadingWidget:initProgress()
	local loadingNode = self:getView():getChildByFullName("bottom.loading.node_pro")
	local moveNode = loadingNode:getChildByName("img_move")
	local modelId = ConfigReader:getRecordById("RoleModel", "Model_ZZBBWei").Model
	local pathPrefix = "asset/anim/"
	local jsonPath = pathPrefix .. modelId .. ".skel"

	if not cc.FileUtils:getInstance():isFileExist(jsonPath) then
		jsonPath = pathPrefix .. "YFZZhu" .. ".skel"
	end

	local node = sp.SkeletonAnimation:create(jsonPath)

	node:setScale(0.5)
	node:playAnimation(0, "run", true)
	node:offset(0, -20)
	node:addTo(moveNode:getChildByName("anim_node"))
	node:setLocalZOrder(-1)

	local rightAnim = cc.MovieClip:create("aa_loading")

	rightAnim:play()
	rightAnim:addTo(loadingNode:getChildByFullName("anim.anim"))

	local loadingAnim = cc.MovieClip:create("cc_loading")

	loadingAnim:play()
	loadingAnim:offset(0, -3)
	loadingAnim:addTo(moveNode)
end

local kBgAnimAndImage = {
	{
		"businiao_choukahuodeyinghun",
		"asset/scene/party_bg_businiao",
		"loading_img_bsn.png",
		"LoadingTips_Power003",
		"LoadingTips_Power103"
	},
	{
		"xide_choukahuodeyinghun",
		"asset/scene/party_bg_xide",
		"loading_img_xd.png",
		"LoadingTips_Power001",
		"LoadingTips_Power101"
	},
	{
		"monv_choukahuodeyinghun",
		"asset/scene/party_bg_monv",
		"loading_img_mnjh.png",
		"LoadingTips_Power005",
		"LoadingTips_Power105"
	},
	{
		"dongwenhui_choukahuodeyinghun",
		"asset/scene/party_bg_dongwenhui",
		"loading_img_dwh.png",
		"LoadingTips_Power004",
		"LoadingTips_Power104"
	},
	{
		"weinasi_weinasixianjing",
		"asset/scene/party_bg_weinasi",
		"loading_img_vnsxj.png",
		"LoadingTips_Power002",
		"LoadingTips_Power102"
	},
	{
		"shebeijing_choukahuodeyinghun",
		"asset/scene/party_bg_sszs",
		"loading_img_smzs.png",
		"LoadingTips_Power006",
		"LoadingTips_Power106"
	}
}

function NewUpdateLoadingWidget:refreshBg()
	local partyData = kBgAnimAndImage[math.random(6)]
	local bgPanel = self:getView():getChildByFullName("bottom.animPanel")

	bgPanel:removeAllChildren()

	local bgAnim = cc.MovieClip:create(partyData[1])

	bgAnim:addTo(bgPanel)

	local bg1 = bgAnim:getChildByFullName("bg1")
	local bg2 = bgAnim:getChildByFullName("bg2")
	local bg3 = bgAnim:getChildByFullName("bg3")

	if bg1 then
		local bgImage = ccui.ImageView:create(partyData[2] .. ".jpg")

		bgImage:addTo(bg1)

		if bg2 and bg3 then
			local bgImage = ccui.ImageView:create(partyData[2] .. "mohu.jpg")

			bgImage:addTo(bg2)

			local bgImage = ccui.ImageView:create(partyData[2] .. "mohu.jpg")

			bgImage:addTo(bg3)
		end
	end

	bgPanel:setScale(1.2)
	bgPanel:runAction(cc.ScaleTo:create(0.2, 1))

	local party_icon = self:getView():getChildByFullName("bottom.party_icon")

	party_icon:removeAllChildren()

	local icon = ccui.ImageView:create(partyData[3], ccui.TextureResType.plistType)

	icon:addTo(party_icon)

	local party_title = self:getView():getChildByFullName("bottom.party_title")

	party_title:setString(Strings:get(partyData[4]))

	local party_text = self:getView():getChildByFullName("bottom.party_text")

	party_text:setString(Strings:get(partyData[5]))
end

function NewUpdateLoadingWidget:onProgress(task, progress)
	local loadingNode = self:getView():getChildByFullName("bottom.loading.node_pro")

	loadingNode:setVisible(true)

	local loadingBar = loadingNode:getChildByName("loading")

	loadingBar:setPercent(progress * 100)

	local moveNode = loadingNode:getChildByName("img_move")

	moveNode:posite(-509 + 975 * progress)

	local progressNum = loadingNode:getChildByFullName("anim.percent_text")

	progressNum:setString(string.format("%d", progress * 100))
end

return {
	GUIDENEWBEE = NewUpdateLoadingWidget
}
