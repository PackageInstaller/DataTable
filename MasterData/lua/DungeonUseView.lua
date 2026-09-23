--特殊道具使用界面
local currentItem = nil;
local currentIndex = 0;
local items = nil;
function Awake()
	LanguageMgr:SetText(txt_use, 1032)
	LanguageMgr:SetText(txt_cancel, 15055)
end

function OnOpen()
	UIUtil:DoLocalMove(root, {0, 0, 0}, function()
		if data then
			items = {};
			for k, v in ipairs(items) do
				CSAPI.SetGOActive(v.gameObject, false);
			end
			if data.currIdx then
				currentIndex = data.currIdx;
			end
			for k, v in ipairs(data.itemList) do
				local tab = nil;
				if k < #items then
					tab = items[k];
				else
					local go = ResUtil:CreateUIGO("Dungeon/DungeonUseSprite", Content.transform);
					tab = ComUtil.GetLuaTable(go);
					table.insert(items, tab);
				end
				tab.Init(k, v, OnClickSprite);
				if currentIndex ~= 0 then
					tab.SetState(k == currentIndex);
				end
			end
		end
	end)
end

function OnClickSprite(item)
	currentIndex = item.GetIndex();
	for k, v in ipairs(items) do
		v.SetState(k == currentIndex);
	end
end

--使用
function OnClickUse()
	if currentIndex == 0 then
		LanguageMgr:ShowTips(8007);
	else
		ClientProto:SetDupUseItem(data.dungeonId, currentIndex, true, function(proto)
			Close();
		end)
	end
end

--不使用
function OnClickCancel()
	currentIndex = 0;
	ClientProto:SetDupUseItem(data.dungeonId, nil, false, function(proto)
		Close();
	end)
end

function OnClickClose()
	Close();
end

function OnClickHome()
	UIUtil:AddHeadPanel(transform, 1)
end


function Close()
	UIUtil:DoLocalMove(root, {- 1136, 0, 0}, function()
		if data.clickFunc then
			data.clickFunc(currentIndex);
		end
		view:Close();
	end)
end
