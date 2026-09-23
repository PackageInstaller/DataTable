--拖拽卡牌视图
local isAddtive=false;
local attrs={};
local maxAttrNum=4;--每次最大显示的数量
local attrIndex=1;--光环属性的显示下标
local currTime=0;
local loopTime=6;--循环时间
local haloInfos=nil;
local isLoop=false;
local hpBarImg=nil;
local spBarImg=nil;
local showFakeLevel = nil

function Awake()
	-- eventMgr = ViewEvent.New();
	-- eventMgr:AddListener(EventType.TeamView_AddtiveState_Change,SetAddtiveState);
	hpBarImg=ComUtil.GetCom(hpBar, "Image");
    spBarImg=ComUtil.GetCom(spBar, "Image");
end

-- function OnDestroy()
-- 	eventMgr:ClearListener();
-- end

function Refresh(teamItem,_isShowInfos,_showFakeLevel)
	data=teamItem;
	showFakeLevel = _showFakeLevel
	SetLv();
	SetTips();
	SetFightObj();
	if _isShowInfos then
		local cardInfo=nil;
		local strs = StringUtil:split(data:GetID(), "_");
		if isNpc and strs[1]~="npc" then
			cardInfo=FormationUtil.GetTowerCardInfo(tonumber(strs[2]),tonumber(strs[1]),TeamMgr.currentIndex);
		else
			cardInfo=FormationUtil.GetTowerCardInfo(data:GetID(),nil,TeamMgr.currentIndex);
		end
		local currHp,currSp=0,0;
		if cardInfo then
			currHp=cardInfo.tower_hp/100;
			currSp=cardInfo.tower_sp/100;
		end
		SetCardInfos(currHp,currSp);
	else
		SetCardInfos();
	end
end

function SetCardInfos(hp,sp)
    if hp and sp then
        CSAPI.SetGOActive(infos,true);
        hpBarImg.fillAmount=hp;
        spBarImg.fillAmount=sp;
    else
        CSAPI.SetGOActive(infos,false);
    end
end

function SetFightObj()
	if data then
		local isFight=TeamMgr:GetCardIsDuplicate(data:GetID());
		CSAPI.SetGOActive(fightingObj,isFight);
	else
		CSAPI.SetGOActive(fightingObj,false);
	end
end

function SetLv()
	if data then
		if showFakeLevel and data:GetLv() < showFakeLevel and RoleMgr:GetData(data:GetID()) ~= nil then--自身拥有
			CSAPI.SetText(txt_lvVal,tostring(showFakeLevel));
			CSAPI.SetTextColorByCode(txt_lvVal,"ff0040")
		else
			CSAPI.SetText(txt_lvVal,tostring(data:GetLv()));
			CSAPI.SetTextColorByCode(txt_lvVal,"ffffff")
		end
	else
		CSAPI.SetText(txt_lvVal,"");
	end
end

function HideHaloAtts()
	CSAPI.SetGOActive(attrObj,false)
end

--受到的光环加成属性
function CreateHaloAtts(infos)
	CSAPI.SetGOActive(attrObj,true);
	if infos then
		haloInfos=infos;
		if #infos>4 then
			isLoop=true;
			currTime=loopTime;
			attrIndex=1;
		else
			isLoop=false;
			FormationUtil.CreateAttrs(haloInfos,attrs,attrNode,true);
		end
		CSAPI.SetGOActive(attrNode,#infos>0);
		CSAPI.SetGOActive(txt_noneAttr,#infos<=0);
	else
		CSAPI.SetGOActive(txt_noneAttr,true);
	end
end

function Update()
	if isLoop then --光环属性大于4条时每间隔五秒循环显示
		currTime=currTime+Time.deltaTime;
		if currTime>=loopTime then
			local list={};
			for i=attrIndex,(attrIndex+maxAttrNum-1) do
				if haloInfos[i]~=nil then
					table.insert(list,haloInfos[i]);
				else
					break;
				end
			end
			CSAPI.ApplyAction(attrNode,"Img_Fade_To_Out",function()
				if gameObject then
					FormationUtil.CreateAttrs(list,attrs,attrNode,true);
					CSAPI.ApplyAction(attrNode,"Img_Fade_To_In");
				end
			end);
			attrIndex=attrIndex+maxAttrNum>#haloInfos and 1 or attrIndex+maxAttrNum
			currTime=0;
		end
	end
end


function SetTips()
	if data then
		CSAPI.SetGOActive(tipsObj,true);
		if data:IsNPC() then
			FormationUtil.LoadTipsIcon(tipsObj,3);
		elseif data:IsAssist() then
			if FormationUtil.CheckAssitCardIsLimit(data) then
				FormationUtil.LoadTipsIcon(tipsObj,4);
			else
				FormationUtil.LoadTipsIcon(tipsObj,2);
			end
		elseif data:IsLeader() then
			FormationUtil.LoadTipsIcon(tipsObj,1);
		else
			CSAPI.SetGOActive(tipsObj,false);
		end
	else
		CSAPI.SetGOActive(tipsObj,false);
	end
end

function GetNode()
	return node;
end

function Close()
	CSAPI.RemoveGO(gameObject);
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
attrObj=nil;
attrNode=nil;
txt_noneAttr=nil;
this=nil;  
node=nil;
lvObj=nil;
txt_lv=nil;
tipsObj=nil;
tipsIcon=nil;
txt_tips=nil;
view=nil;
end
----#End#----