--拖拽卡牌视图
local isDamage = false;
local stars=nil;
local gridSize=nil;
local attrs={};
local maxAttrNum=2;--每次最大显示的数量
local attrIndex=1;--光环属性的显示下标
local currTime=0;
local loopTime=6;--循环时间
local haloInfos=nil;
local descTxts=nil;
local hpBarImg=nil;
local spBarImg=nil;
local showFakeLevel=nil;--低于指定等级显示特定等级

function Awake()
	local imgs = ComUtil.GetComsInChildren(gameObject, "Image", true);
	upTween = ComUtil.GetCom(txt_topAddVal, "ActionNumberRunner");
    centerTween = ComUtil.GetCom(txt_centerAddVal, "ActionNumberRunner");
	downTween = ComUtil.GetCom(txt_downAddVal, "ActionNumberRunner");
	descTxts={{txt_topAdd,txt_topAddVal,upTween},{txt_centerAdd,txt_centerAddVal,centerTween},{txt_downAdd,txt_downAddVal,downTween}};
	hpBarImg=ComUtil.GetCom(hpBar, "Image");
    spBarImg=ComUtil.GetCom(spBar, "Image");
end

--设置数据 k:当前 _isShowInfos:是否显示hp/sp条
function InitData(data,isLeader,_isMini,_isMirror,_isShowInfos,_showFakeLevel)
	isMirror = _isMirror==nil and false or _isMirror
	showFakeLevel = _showFakeLevel
	if(isMirror) then 
		SetDragEnable()
	end
	-- SetStyle(_isMini);
	if data == nil then
		this.data=nil;
		LogError("卡牌数据不能为nil");
		return
	end
	this.data=data;

	if data.bIsNpc==false and not isMirror then
		local cfg=data:GetModelCfg();
		if cfg~=nil then
			FormationUtil.Load2DImg(icon,cfg,data:GetGrids());
		end
		-- ResUtil.FormationIcon:Load(icon,cfg.formation_icon);
		SetGridSize(data:GetGrids());
	else
		local cfg=data:GetCfg();
		if cfg~=nil then
			skinID=cfg.model;
        end
        local modelCfg=Cfgs.character:GetByID(skinID);
		if modelCfg then
			FormationUtil.Load2DImg(icon,modelCfg,data:GetGrids());
		end
        -- ResUtil.FormationIcon:Load(icon,modelCfg.formation_icon);
        SetGridSize(cfg.grids);
    end
	if _isShowInfos then
		local cardInfo=nil;
		local strs = StringUtil:split(data:GetID(), "_");
		if strs and #strs>1 and strs[1]~="npc" then
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
	SetHaloCfg();
	if showFakeLevel and data:GetLv() < showFakeLevel and RoleMgr:GetData(data:GetID()) ~= nil then --自身拥有
		CSAPI.SetText(txt_lv,tostring(showFakeLevel));
		CSAPI.SetTextColorByCode(txt_lv,"ff0040")
	else
		CSAPI.SetText(txt_lv,tostring(data:GetLv()));
		CSAPI.SetTextColorByCode(txt_lv,"000000")
	end
	SetSupport(data:IsAssist());
	local isFight=TeamMgr:GetCardIsDuplicate(data:GetID());
	SetFightObj(isFight);
	SetTips();
	-- CSAPI.SetGOActive(attrObj,false);
	ShowArrow(false);
    -- 
	HideObjWeapon(false)
end

function HideObjWeapon(isShow)
	if(isShow)then 
		CSAPI.SetGOActive(objWeapon,false)
	else 
		local cardData=data:GetCard()
    	RoleTool.SetWeapon(cardData,objWeapon,imgWeapon,txtWeaponLv)

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

function SetHaloCfg()
    if this.data then
        local haloInfo = this.data:GetHaloInfo();
        if (haloInfo == nil) then -- 光环范围
            do
                return
            end -- 没有光环
        end
        haloInfo:LoadIcon(haloIcon)
        CSAPI.SetRTSize(haloIcon, 60, 60);
        --    读取光环加成
        local attrDatas = HaloUtil.CountHaloAddtion(haloInfo, this.data:GetCard(), nil, nil, nil, nil);
        for k, v in ipairs(attrDatas) do
            if v.cfg then
                local addtive = 0;
                local endStr = "";
                if HaloUtil.fixedList[v.cfg.sFieldName]==nil then
                    addtive = v.addtive and  tonumber(string.match(v.addtive, "%d+")) or 0;
                    endStr = "%"
                else
                    addtive = v.addtiveNum or 0;
                end
                CSAPI.SetText(descTxts[k][1], v.cfg.sName2);
                descTxts[k][3].currentNum = 0;
                descTxts[k][3].fixedBStr = endStr;
                descTxts[k][3].targetNum = addtive;
                descTxts[k][3]:Play();
            end
        end
        CSAPI.SetGOActive(down, #attrDatas >= 3);
    end
    -- CSAPI.SetGOActive(topLine,index>1);
end


function SetTween(isShow)
	CSAPI.SetGOActive(tweenObj,isShow);
	CSAPI.SetGOActive(attrTween,isShow);
end

function SetTips()
	if data then
		CSAPI.SetGOActive(tipsIcon,true);
		if data:IsLeader() then
			FormationUtil.LoadTipsIcon(tipsIcon,1);
		elseif data:IsNPC() then
			FormationUtil.LoadTipsIcon(tipsIcon,3);
		elseif data:IsAssist() then
			if FormationUtil.CheckAssitCardIsLimit(data) then
				FormationUtil.LoadTipsIcon(tipsIcon,4);
			else
				FormationUtil.LoadTipsIcon(tipsIcon,2);
			end
		else
			CSAPI.SetGOActive(tipsIcon,false);
		end
	else
		CSAPI.SetGOActive(tipsIcon,false);
	end
end

function HideHaloAtts()
	if attrObj.activeSelf then
		CSAPI.SetGOActive(lvTween,true);
	end
	CSAPI.SetGOActive(attrObj,false)
	CSAPI.SetAnchor(lvObj,116,22)
end

--受到的光环加成属性
function CreateHaloAtts(infos)
	CSAPI.SetGOActive(attrObj,true);
	CSAPI.SetAnchor(lvObj,116,96)
	CSAPI.SetGOActive(lvTween,false);
	if infos then
		haloInfos=infos;
		if #infos>maxAttrNum then
			isLoop=true;
			currTime=loopTime;
			attrIndex=1;
		else
			isLoop=false;
			FormationUtil.CreateAttrs(haloInfos,attrs,attrNode,true);
		end
		CSAPI.SetGOActive(attrTri,isLoop==true);
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

function SetFightObj(_isShow)
	local isShow=_isShow==true and true or false;
	CSAPI.SetGOActive(fightingObj,isShow);
end

function SetGridColor(type)
	local color=FormationUtil.GetHalo2DGridColor(type)
	local color2=FormationUtil.GetHalo2DBorderColor(type)
	CSAPI.SetImgColor(bnode,color2[1],color2[2],color2[3],color2[4]);
    CSAPI.SetImgColor(border,color[1],color[2],color[3],color[4]);
end

function SetGridSize(gridType)
    local size=FormationUtil.GetGridSize(gridType,false);
	local size2=FormationUtil.GetBgSize(gridType,false);
	CSAPI.SetRectSize(bg,size2[1],size2[2]);
	CSAPI.SetRectSize(border,size[1],size[2]);
    CSAPI.SetRectSize(gameObject,size[1],size[2]);
end

function SetSelectModel(isShow)
	isShow=isShow==true and true or false;
	CSAPI.SetGOActive(lvObj,not isShow);
	SetTopMask(isShow);
end

function SetTopMask(isShow)
	CSAPI.SetGOActive(topmask,isShow);
end

-- function SetGridImg(row,col,coord)
-- 	local bgName="btn_4_03.png";
-- 	local rotate=0;
-- 	local iRow=row;
-- 	local iCol=col;
-- 	if coord then
-- 		for k,v in ipairs(coord) do
-- 			local r = row + v[1] - 1;
-- 			local c = col + v[2] - 1;
-- 			if r==3 and c==3 then
-- 				iRow=3;
-- 				iCol=3;
-- 				break;
-- 			end
-- 		end
-- 	end
-- 	if iRow==1 and iCol==1 then
-- 		bgName="btn_4_07.png";
-- 	elseif iRow==3 and iCol==3 then
-- 		bgName="btn_4_06.png";
-- 	elseif iRow==3 and iCol==1 then
-- 		rotate=180;
-- 	end
-- 	CSAPI.LoadImg(bg,"UIs/Formation/"..bgName,false,nil,true);
-- 	CSAPI.SetRectAngle(bg,0,0,rotate);
-- 	if row ==3 and col ==1 then
-- 		CSAPI.SetAngle(node,0,0,180);
-- 	else
-- 		CSAPI.SetAngle(node,0,0,0);
-- 	end
-- end

--设置位置
function SetParent(go, offset)
	if go and offset then
        --设置新的父物体
		CSAPI.SetParent(gameObject, go)
		--设置位置
		CSAPI.SetLocalPos(gameObject, offset.x, offset.y, offset.z);
	end
end

function ShowArrow(isShow)
	-- CSAPI.SetGOActive(choosieObj,isShow);
end

--移动 pos:世界坐标
function Move(pos)
	transform.position=pos;
end

--设置物体层级
function SetSibling()
	CSAPI.SetParent(gameObject, view.myParent.parent.gameObject)
	transform:SetAsLastSibling();
end

function Close()
	if(luaModel) then
		luaModel.Remove();
		luaModel=nil;
	end
	view:Close();
end

function SetSupport(isShow)
	CSAPI.SetGOActive(supportObj,isShow or false);
end

--用来验证是否可以被放置到阵型的物体
function GetTag()
	return "TeamDrag"
end

function GetPos()
	local x,y,z =CSAPI.GetPos(gameObject);
	return x,y,z;
end

-----------------------演习-------------------------------------------------
--禁用拖拽
function SetDragEnable()
	local drag =  ComUtil.GetCom(gameObject, "DragCallLua")
	drag.enabled = false
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
bg=nil;
bnode=nil;
node=nil;
icon=nil;
attrObj=nil;
attrNode=nil;
txt_noneAttr=nil;
lvObj=nil;
txt_lv=nil;
border=nil;
tipsObj=nil;
tipsIcon=nil;
txt_tips=nil;
view=nil;
end
----#End#----