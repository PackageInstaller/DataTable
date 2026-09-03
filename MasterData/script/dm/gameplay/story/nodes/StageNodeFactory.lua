-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/nodes/StageNodeFactory.lua

module("story", package.seeall)

StageNodeFactory = {
	__creators = {}
}

function StageNodeFactory:addNodeClass(name, clazz)
	local creators = self.__creators

	assert(creators[name] == nil, string.format("Duplicate node name \"%s\"", name))

	creators[name] = function(...)
		return clazz:new(...)
	end
end

function StageNodeFactory:addNodeCreator(name, creatorFunction)
	local creators = self.__creators

	assert(creators[name] == nil, string.format("Duplicate node name \"%s\"", name))

	creators[name] = creatorFunction
end

function StageNodeFactory:createNodeWithConfig(config)
	if config == nil then
		return nil
	end

	local nodeType = config.type

	if nodeType == nil then
		return nil
	end

	local creator = self.__creators[nodeType]

	if creator == nil then
		return nil
	end

	local node = creator(config)

	if node == nil then
		return nil
	end

	local actions = config.__actions__

	if actions then
		node:extendActionsForObject(actions)
	end

	local children = config.children

	if children then
		for _, cfg in ipairs(children) do
			local child = self:createNodeWithConfig(cfg)

			if child then
				node:addChild(child, cfg.zorder, cfg.name)
			end
		end
	end

	return node
end

function StageNodeFactory:createRootNodeWithConfig(config)
	if config == nil then
		return nil
	end

	local nodeType = config.type

	if nodeType == nil then
		return nil
	end

	local creator = self.__creators[nodeType]

	if creator == nil then
		return nil
	end

	local node = creator(config)

	if node == nil then
		return nil
	end

	local actions = config.__actions__

	if actions then
		node:extendActionsForObject(actions)
	end

	return node
end

local kUIComponentZOrder = {
	kNews = 1020,
	kDialogueSkipChoose = 1300,
	kFriendLove = 1201,
	kGuider = 200,
	kSkipButton = 1100,
	kFlashMask = 90,
	kPrinterEffect = 1050,
	kRenameDialog = 1210,
	kDialogueChoose = 1200,
	kCurtain = 1000,
	kGuideMask = 100,
	kDialogTip = 1400,
	kDialogue = 300,
	kClick = 500
}
local DF_UISIZE_W = 1136
local DF_UISIZE_H = 640
local uiComponentConfigs = {
	{
		stretchHeight = true,
		type = "Dialogue",
		displayType = "ui",
		stretchWidth = false,
		id = "dialogue",
		layoutMode = 1,
		size = {
			width = DF_UISIZE_W,
			height = DF_UISIZE_H
		},
		zorder = kUIComponentZOrder.kDialogue,
		anchorPoint = {
			x = 0.5,
			y = 0
		},
		position = {
			refpt = {
				x = 0.5,
				y = 0
			}
		}
	},
	{
		layoutMode = 1,
		displayType = "ui",
		type = "Option",
		id = "option",
		size = {
			width = DF_UISIZE_W,
			height = DF_UISIZE_H
		},
		zorder = kUIComponentZOrder.kDialogue,
		anchorPoint = {
			x = 0.5,
			y = 0.5
		},
		position = {
			refpt = {
				x = 0.5,
				y = 0.5
			}
		}
	},
	{
		layoutMode = 1,
		displayType = "ui",
		type = "StoryNewsNode",
		id = "newsNode",
		size = {
			width = DF_UISIZE_W,
			height = DF_UISIZE_H
		},
		zorder = kUIComponentZOrder.kNews,
		anchorPoint = {
			x = 0.5,
			y = 0.5
		},
		position = {
			refpt = {
				x = 0.5,
				y = 0.5
			}
		}
	},
	{
		id = "curtain",
		displayType = "ui",
		type = "Curtain",
		zorder = kUIComponentZOrder.kCurtain
	},
	{
		id = "flashMask",
		displayType = "ui",
		type = "FlashMask",
		zorder = kUIComponentZOrder.kFlashMask
	},
	{
		id = "click",
		displayType = "ui",
		type = "Click",
		zorder = kUIComponentZOrder.kClick
	},
	{
		id = "dragGuide",
		displayType = "ui",
		type = "DragGuide",
		zorder = kUIComponentZOrder.kClick + 1
	},
	{
		id = "showNode",
		displayType = "ui",
		type = "ShowNode",
		zorder = kUIComponentZOrder.kGuider - 1
	},
	{
		layoutMode = 1,
		displayType = "ui",
		type = "PrinterEffect",
		id = "printerEffect",
		size = {
			width = DF_UISIZE_W,
			height = DF_UISIZE_H
		},
		zorder = kUIComponentZOrder.kPrinterEffect,
		anchorPoint = {
			x = 0.5,
			y = 0.5
		},
		position = {
			refpt = {
				x = 0.5,
				y = 0.5
			}
		}
	},
	{
		layoutMode = 1,
		displayType = "ui",
		type = "ChapterDialog",
		id = "chapterDialog",
		size = {
			width = DF_UISIZE_W,
			height = DF_UISIZE_H
		},
		zorder = kUIComponentZOrder.kPrinterEffect,
		anchorPoint = {
			x = 0.5,
			y = 0.5
		},
		position = {
			refpt = {
				x = 0.5,
				y = 0.5
			}
		}
	},
	{
		layoutMode = 1,
		displayType = "ui",
		type = "WorldScrollText",
		id = "worldScrollText",
		size = {
			width = DF_UISIZE_W,
			height = DF_UISIZE_H
		},
		zorder = kUIComponentZOrder.kPrinterEffect,
		anchorPoint = {
			x = 0.5,
			y = 0.5
		},
		position = {
			refpt = {
				x = 0.5,
				y = 0.5
			}
		}
	},
	{
		layoutMode = 1,
		displayType = "ui",
		type = "DialogueChoose",
		id = "dialogueChoose",
		size = {
			width = DF_UISIZE_W,
			height = DF_UISIZE_H
		},
		zorder = kUIComponentZOrder.kDialogueChoose,
		anchorPoint = {
			x = 0.5,
			y = 0.5
		},
		position = {
			refpt = {
				x = 0.5,
				y = 0.5
			}
		}
	},
	{
		id = "guideMask",
		displayType = "ui",
		type = "Mask",
		zorder = kUIComponentZOrder.kGuideMask
	},
	{
		id = "guider",
		displayType = "ui",
		type = "Guider",
		zorder = kUIComponentZOrder.kGuider
	},
	{
		id = "guideText",
		displayType = "ui",
		type = "GuideText",
		zorder = kUIComponentZOrder.kGuider
	},
	{
		id = "guideDragLine",
		displayType = "ui",
		type = "GuideDragLine",
		zorder = kUIComponentZOrder.kGuider
	},
	{
		id = "skipButton",
		displayType = "ui",
		type = "SkipButton",
		anchorPoint = {
			x = 1,
			y = 1
		},
		position = {
			x = 0,
			y = -10,
			refpt = {
				x = 1,
				y = 1
			}
		},
		zorder = kUIComponentZOrder.kSkipButton
	},
	{
		id = "guideSkipButton",
		displayType = "ui",
		type = "GuideSkipButton",
		anchorPoint = {
			x = 0.5,
			y = 0.5
		},
		position = {
			x = 0,
			y = 10,
			refpt = {
				x = 0.5,
				y = 0
			}
		},
		zorder = kUIComponentZOrder.kSkipButton
	},
	{
		id = "reviewButton",
		displayType = "ui",
		type = "ReviewButton",
		anchorPoint = {
			x = 1,
			y = 1
		},
		position = {
			x = -110,
			y = -26,
			refpt = {
				x = 1,
				y = 1
			}
		},
		zorder = kUIComponentZOrder.kSkipButton
	},
	{
		id = "autoPlayButton",
		displayType = "ui",
		type = "AutoPlayButton",
		anchorPoint = {
			x = 1,
			y = 1
		},
		position = {
			x = -190,
			y = -26,
			refpt = {
				x = 1,
				y = 1
			}
		},
		zorder = kUIComponentZOrder.kSkipButton
	},
	{
		id = "hideButton",
		displayType = "ui",
		type = "HideButton",
		anchorPoint = {
			x = 1,
			y = 1
		},
		position = {
			x = -270,
			y = -26,
			refpt = {
				x = 1,
				y = 1
			}
		},
		zorder = kUIComponentZOrder.kSkipButton
	}
}

function StageNodeFactory:createScene(config)
	local scene = self:createRootNodeWithConfig(config)
	local children = {}

	if config.children then
		for k, v in pairs(config.children) do
			if v.id then
				children[v.id] = v
			end
		end
	end

	for k, v in pairs(uiComponentConfigs) do
		if v.id then
			children[v.id] = v
		end
	end

	scene:setChildrenList(children)

	return scene
end

function StageNodeFactory:createRenameDialog(scene)
	local data = {
		layoutMode = 1,
		displayType = "ui",
		type = "RenameDialog",
		id = "renameDialog",
		size = {
			width = DF_UISIZE_W,
			height = DF_UISIZE_H
		},
		zorder = kUIComponentZOrder.kRenameDialog,
		anchorPoint = {
			x = 0.5,
			y = 0.5
		},
		position = {
			refpt = {
				x = 0.5,
				y = 0.5
			}
		}
	}
	local node = self:createNodeWithConfig(data)

	scene:addChild(node, data.zorder)
	node:refreshLayout()

	return node
end

function StageNodeFactory:createStoryChooseDialog(scene)
	local data = {
		layoutMode = 1,
		displayType = "ui",
		type = "StoryChoose",
		id = "storyChooseDialog",
		size = {
			width = DF_UISIZE_W,
			height = DF_UISIZE_H
		},
		zorder = kUIComponentZOrder.kRenameDialog,
		anchorPoint = {
			x = 0.5,
			y = 0.5
		},
		position = {
			refpt = {
				x = 0.5,
				y = 0.5
			}
		}
	}
	local node = self:createNodeWithConfig(data)

	scene:addChild(node, data.zorder)
	node:refreshLayout()

	return node
end

function StageNodeFactory:createReviewDialog(scene)
	local data = {
		layoutMode = 1,
		displayType = "ui",
		type = "Review",
		id = "review",
		size = {
			width = DF_UISIZE_W,
			height = DF_UISIZE_H
		},
		zorder = kUIComponentZOrder.kDialogueChoose,
		anchorPoint = {
			x = 0.5,
			y = 0.5
		},
		position = {
			refpt = {
				x = 0.5,
				y = 0.5
			}
		}
	}
	local node = self:createNodeWithConfig(data)

	scene:addChild(node, data.zorder)
	node:refreshLayout()

	return node
end

function StageNodeFactory:createSkipChooseDialog(scene)
	local data = {
		layoutMode = 1,
		displayType = "ui",
		type = "SkipChoose",
		id = "skipChoose",
		size = {
			width = DF_UISIZE_W,
			height = DF_UISIZE_H
		},
		zorder = kUIComponentZOrder.kDialogueSkipChoose,
		anchorPoint = {
			x = 0.5,
			y = 0.5
		},
		position = {
			refpt = {
				x = 0.5,
				y = 0.5
			}
		}
	}
	local node = self:createNodeWithConfig(data)

	scene:addChild(node, data.zorder)
	node:refreshLayout()

	return node
end

function StageNodeFactory:createStoryLove(scene)
	local data = {
		id = "storyLove",
		displayType = "ui",
		type = "StoryLove",
		anchorPoint = {
			x = 1,
			y = 1
		},
		position = {
			refpt = {
				x = 0.8,
				y = 0.37
			}
		},
		zorder = kUIComponentZOrder.kFriendLove
	}
	local node = self:createNodeWithConfig(data)

	scene:addChild(node, data.zorder)
	node:refreshLayout()

	return node
end

function StageNodeFactory:createMazeClue(scene)
	local data = {
		id = "mazeClue",
		displayType = "ui",
		type = "MazeClue",
		anchorPoint = {
			x = 1,
			y = 1
		},
		position = {
			refpt = {
				x = 0.85,
				y = 0.43
			}
		},
		zorder = kUIComponentZOrder.kFriendLove
	}
	local node = self:createNodeWithConfig(data)

	scene:addChild(node, data.zorder)
	node:refreshLayout()

	return node
end

function StageNodeFactory:createMazeNewClueTip(scene)
	local data = {
		displayType = "ui",
		type = "MazeNewClueTip",
		id = "mazeNewClueTip",
		layoutMode = 1,
		zorder = kUIComponentZOrder.kDialogTip,
		anchorPoint = {
			x = 0.5,
			y = 0.5
		},
		position = {
			refpt = {
				x = 0.5,
				y = 0.5
			}
		}
	}
	local node = self:createNodeWithConfig(data)

	scene:addChild(node, data.zorder)
	node:refreshLayout()

	return node
end
