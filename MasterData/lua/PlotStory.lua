--剧情故事界面
local lineHeight = 60;
local currY = 0;
local fade = nil
local items = {}
function OnOpen()
	LanguageMgr:SetText(txt_return, 1004)
	fade = ComUtil.GetCom(gameObject, "ActionFade")
	AnimStart()

	if data then
		if openSetting and openSetting.isLovePlus then
			RefreshLovePlus()
		else
			Refresh();
		end
	end
end

function Refresh()
	local plot = data.story:GetBeginPlotData();
	local index = 1;
	local optionIndex = 1
	items = {}
	fade:Play(0, 1, 250, 0,AnimEnd)
	while(plot:GetNextPlotInfo() ~= nil or(plot:GetKey() == "PlotData" and plot:GetOptions() ~= nil)) do
		if plot:GetContent() ~= nil then
			if (plot:GetKey() == "PlotData" and plot:GetShowStory()) or plot:GetKey() == "PlotOption" then
				ResUtil:CreateUIGOAsync("Plot/PlotStoryItem", Content, function(go)
					local lua = ComUtil.GetLuaTable(go);
					lua.Refresh(plot);
					SetPos(lua, index);	
					table.insert(items, 1, lua)
					--lua.SetFadeIn()			
				end);
			end
			if(data.currPlot and plot:GetID() == data.currPlot:GetID() and plot:GetKey() == data.currPlot:GetKey()) then
				break;
			elseif plot:GetKey() == "PlotData" and plot:GetOptions() ~= nil then
				local cid = data.options[plot:GetID()];
				if (not cid or cid == 0) then --处理跳转在选项后发生的报错
					local cfg = plot:GetOptions()[1].cfg
					cid = cfg.id
				end
				plot = PlotOption.New();
				plot:InitCfg(cid);
				optionIndex = optionIndex + 1
			elseif plot:GetNextPlotInfo() then
				plot = plot:GetNextPlotInfo();
			end
			index = index + 1;
		end
	end
	--只对最后4个做动效
	for i = 1, #items do
		if #items <= 4 then
			items[#items - i + 1].SetFadeIn(i)
		elseif i > #items - 4 then
			items[#items - i + 1].SetFadeIn(i -(#items - 4))
		end
	end
	
	-- CSAPI.SetRTSize(Content, 1681, math.abs(currY - 100));
	CSAPI.SetRTSize(Content, 1681, math.abs(currY));
	if index > 4 then
		CSAPI.SetAnchor(Content, 0, math.abs(currY) - 956)
	end
end

function RefreshLovePlus()
	local plot = data.story:GetBeginPlotData();
	local index = 1;
	items = {}
	fade:Play(0, 1, 250, 0,AnimEnd)
	local readOptions = {} 
	while(plot:GetNextPlotInfo() ~= nil) do
		if plot:GetContent() ~= nil and plot:GetShowStory() ~= nil then
			ResUtil:CreateUIGOAsync("Plot/PlotStoryItem", Content, function(go)
				local lua = ComUtil.GetLuaTable(go);
				lua.Refresh(plot);
				SetPos(lua, index);	
				table.insert(items, 1, lua)
			end);

			if data.currPlot and plot:GetID() == data.currPlot:GetID() then
				break
			end

			local options = plot:GetOptions()
			if options ~= nil then			
				if #options > 1 then
					for i, v in ipairs(options) do
						if LovePlusMgr:IsPlotRead(v:GetID()) and readOptions[v:GetID()] == nil then
							readOptions[v:GetID()] = 1
							plot = v
							break
						end
					end
				else
					plot= options[1]
				end
			else
				plot = plot:GetNextPlotInfo()
			end
			index = index + 1;
		else
			plot = plot:GetNextPlotInfo()
		end
	end
	--只对最后4个做动效
	for i = 1, #items do
		if #items <= 4 then
			items[#items - i + 1].SetFadeIn(i)
		elseif i > #items - 4 then
			items[#items - i + 1].SetFadeIn(i -(#items - 4))
		end
	end
	
	CSAPI.SetRTSize(Content, 0, math.abs(currY));
	if index > 4 then
		CSAPI.SetAnchor(Content, 0, math.abs(currY) - 956)
	end
end

function SetPos(lua, index)
	local height = lua.GetHeight();
	CSAPI.SetRTSize(lua.gameObject,1681,height)
	currY = index == 1 and currY or currY - lineHeight;
	CSAPI.SetAnchor(lua.gameObject, 34, currY);
	currY = currY - height;
end

function OnClickReturn()
	view:Close();
end

function AnimStart()
	if not UIMask then
		UIMask = CSAPI.GetGlobalGO("UIClickMask")
	end
	CSAPI.SetGOActive(UIMask, true)
end

function AnimEnd()
	CSAPI.SetGOActive(UIMask, false)
end

function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this["Scroll View"] = nil;
	Content = nil;
	txt_return = nil;
	view = nil;
	this = nil;
end
----#End#----
