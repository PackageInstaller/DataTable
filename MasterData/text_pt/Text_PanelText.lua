__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_PanelText = readonly({
  PanelText_Battle_UltiSkill_Painting_EX_Text_C_UltiSkill_Content = {
    Text = "Explosão Superalimentada"
  },
  PanelText_Btn_Block_Window_Text_C_Display_Content = {
    Text = "Mostrar cartão"
  },
  PanelText_Btn_Block_Window_Text_C_Hide_Content = {
    Text = "Cartão Oculto"
  },
  PanelText_Btn_Get_Text_Name_Content = {Text = "Receber"},
  PanelText_Com_RedDot_Text_C_GroupNew_Content = {Text = "Novo"},
  PanelText_Com_RedDot_Text_C_New_Content = {Text = "Novo"},
  PanelText_Com_Text_New_Text_C_New_Content = {Text = "Novo"},
  ["PanelText_GmPanel_Text_C_Battle_Test (1)_Content"] = {
    Text = "Batalha 2.0"
  },
  PanelText_GmPanel_Text_C_Battle_Test2_Content = {
    Text = "PvP batalha"
  },
  PanelText_GmPanel_Text_C_Battle_Test_Content = {
    Text = "Partida PvP"
  },
  PanelText_GmPanel_Text_C_Gb_Content = {Text = "Fechar"},
  PanelText_GmPanel_Text_C_Hm_Content = {
    Text = "Trocando entre efeitos gráficos alto/baixo"
  },
  PanelText_GmPanel_Text_C_Placeholder_Content = {
    Text = "Digite para buscar"
  },
  PanelText_GmPanel_Text_C_Xy_Content = {
    Text = "Protocolo de teste"
  },
  PanelText_GmPanel_Text_C_Yc_Content = {
    Text = "Ocultar painel GM"
  },
  PanelText_GmParamEquipPanel_Text_C_Fs_Content = {Text = "Enviar"},
  PanelText_GmParamEquipPanel_Text_C_Tc_Content = {Text = "Sai daqui"},
  PanelText_GmParamPanel_Text_C_Fs_Content = {Text = "Enviar"},
  PanelText_GmParamPanel_Text_C_Param_Content = {
    Text = "Configuração"
  },
  PanelText_GmParamPanel_Text_C_Tc_Content = {Text = "Sai daqui"},
  PanelText_Icon_Common_Text_C_New_Content = {Text = "Novo"},
  PanelText_Icon_Common_Text_C_NoEquip_Content = {
    Text = "Não pode ser equipado"
  },
  PanelText_Item_Battle_AwakerSkill_1_Text_C_CD_Content = {Text = "Resfriando"},
  PanelText_Item_Battle_AwakerSkill_1_Text_C_Ready_Content = {
    Text = "Fúria Explosiva"
  },
  PanelText_Panel_Announcement_Text_C_Panel_Title_Content = {Text = "Aviso"},
  PanelText_Panel_Battle_Monster_Information_Text_C_Monster_Content = {
    Text = "Intenção do Monstro"
  },
  PanelText_Panel_Battle_Monster_Information_Text_C_Story_Content = {
    Text = "História do Monstro"
  },
  PanelText_Panel_Gm_Battle_Art_Entry_Text_C_Canel_Content = {Text = "Cancelar"},
  PanelText_Panel_Gm_Battle_Art_Entry_Text_C_Confirm_Content = {Text = "Confirmar"},
  PanelText_Panel_Gm_Battle_Dbg_Entry_Text_C_Canel_Content = {Text = "Cancelar"},
  PanelText_Panel_Gm_Battle_Dbg_Entry_Text_C_Enter_Content = {Text = "Desafio"},
  PanelText_Panel_Gm_PVP_Text_C_Canel_Content = {Text = "Cancelar"},
  PanelText_Panel_Gm_PVP_Text_C_Confirm_Content = {Text = "Confirmar"},
  PanelText_Popup_Gm_Effect_Side_Text_Content = {
    Text = "Editar Efeito"
  },
  PanelText_Popup_Gm_Effect_Text_Cancel_Content = {Text = "Fechar"},
  PanelText_Popup_Gm_Effect_Text_Confirm_Content = {Text = "Confirmar"},
  PanelText_RedPoint_New_Text_C_New_Content = {Text = "Novo"},
  PanelText_Simple_List_Panel_Text_Content = {Text = "Fechar"},
  PanelText_Text_C_Activate_Text_C_Activate_Content = {
    Text = "Material de ativação"
  },
  PanelText_UI_Address_Panel_Main_Text_C_NoTask1_Content = {
    Text = "Escolha contato"
  },
  PanelText_UI_Address_Panel_Main_Text_C_Title_Content = {
    Text = "Comunicador"
  },
  PanelText_UI_Address_Panel_Main_Text_Time_Content = {
    Text = "Clique na lista para selecionar"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_C_NoTask_Content = {
    Text = "Sem novas mensagens"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Address_Panel_NewMessage_Text_Title_Content = {
    Text = "Comunicador"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Achievement_Content = {
    Text = "Desintegração do pacto"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Alchemy_Content = {
    Text = "Síntese de materiais"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Permute_Content = {
    Text = "Substituição de materiais"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_Recast_Content = {
    Text = "Reimpressão do pacto"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_ResolveItem_Content = {
    Text = "Sintoma: Crash de Material"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_C_ResolveWeapon_Content = {
    Text = "Desmontar roda do destino"
  },
  PanelText_UI_Alchemy_Panel_Main_Text_Title_Content = {Text = "Alquimia"},
  PanelText_UI_Alchemy_Popup_Break_Down_Placeholder_Content = {
    Text = "Clique para digitar resposta"
  },
  PanelText_UI_Alchemy_Popup_MyTeam_Awaker_List_Optimize_Text_Btn_Save_Content = {Text = "Salvar"},
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Name_Content = {
    Text = "Substituição"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Possess_Tips_Content = {
    Text = "Substituindo"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Tips_Content = {
    Text = "Nenhum item para desmontar"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Title_Content = {
    Text = "Materiais Necessários para Substituição"
  },
  PanelText_UI_Alchemy_Popup_Permute_Text_C_Whole_Content = {
    Text = "Selecionar tudo"
  },
  PanelText_UI_Alchemy_Popup_Recast_Text_C_Name_Content = {
    Text = "Reimpressão"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_All_Content = {
    Text = "Selecionar tudo"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Cap_Content = {
    Text = "Fortalecido até o limite atual de nível"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_GoodsNum_Content = {Text = "Quantidade"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Mail_Content = {Text = "Regras"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_MaterialsNull_Content = {
    Text = "Sem pacto relacionado"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_NormotopiaCap_Content = {
    Text = "Alinhamento atingiu o limite máximo"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Null_Content = {
    Text = "Escolha os itens a desmontar"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Resolve_Content = {
    Text = "Desmontagem concluída"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Optimize_Text_C_Sel_Content = {
    Text = "Selecionado"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_C_Screen_Content = {Text = "Filtrar"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Confirm_Content = {Text = "Confirmar"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_Reset_Content = {Text = "Resetar"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle1_Content = {Text = "Conjunto"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle2_Content = {Text = "Posição"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle3_Content = {
    Text = "Atributo Principal"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Sift2_Text_SiftTitle4_Content = {
    Text = "Atributo secundário"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_SiftTitle_Text_C_Tips_Content = {
    Text = "Clique para selecionar"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_All_Content = {
    Text = "Selecionar tudo"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Cap_Content = {
    Text = "Fortalecido até o limite atual de nível"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_GoodsNum_Content = {Text = "Quantidade"},
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_MaterialsNull_Content = {
    Text = "Sem pacto relacionado"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_NormotopiaCap_Content = {
    Text = "Limite de empilhamento atingido"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Null_Content = {
    Text = "Escolha os itens a desmontar"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Resolve_Content = {
    Text = "Desmontagem concluída"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_C_Sel_Content = {
    Text = "Selecionado"
  },
  PanelText_UI_Alchemy_Popup_ResolveMaterials_Text_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_All_Content = {
    Text = "Selecionar tudo"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Cap_Content = {
    Text = "Fortalecido até o limite atual de nível"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_GoodsNum_Content = {Text = "Quantidade"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Mail_Content = {Text = "Regras"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_NormotopiaCap_Content = {
    Text = "Alinhamento atingiu o limite máximo"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Null_Content = {
    Text = "Escolha os itens a desmontar"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Resolve_Content = {
    Text = "Desmontagem concluída"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_Sel_Content = {
    Text = "Selecionado"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Optimize_Text_C_WeaponNull_Content = {
    Text = "Sem destino relacionado"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_All_Content = {
    Text = "Selecionar tudo"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Cap_Content = {
    Text = "Fortalecido até o limite atual de nível"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_GoodsNum_Content = {Text = "Quantidade"},
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_NormotopiaCap_Content = {
    Text = "Limite de empilhamento atingido"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Null_Content = {
    Text = "Escolha os itens a desmontar"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Resolve_Content = {
    Text = "Desmontagem concluída"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_Sel_Content = {
    Text = "Selecionado"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_C_WeaponNull_Content = {
    Text = "Sem destino relacionado"
  },
  PanelText_UI_Alchemy_Popup_ResolveWeapon_Text_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_C_Name_Content = {Text = "Desmontar"},
  PanelText_UI_Alchemy_Popup_Resolve_Text_C_Whole_Content = {
    Text = "Selecionar tudo"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_None_Tips_Content = {
    Text = "Por favor, escolha os materiais a serem desmontados à esquerda"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Possess_Tips_Content = {
    Text = "Desintegrando"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Slider_Tips_Content = {
    Text = "Número de desmontagens"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Tips_Content = {
    Text = "Sem materiais para decompor"
  },
  PanelText_UI_Alchemy_Popup_Resolve_Text_Title_Content = {
    Text = "Desmontar para obter materiais"
  },
  PanelText_UI_Alchemy_Popup_Suit_Item1_Text_C_Have_Content = {Text = "Tem"},
  PanelText_UI_Alchemy_Popup_Suit_Item1_Text_C_Not_Content = {Text = "Nenhum"},
  PanelText_UI_Announcement_Item_Title_Text_New_Info_Content = {Text = "Novo"},
  PanelText_UI_Awaker_Button_Addition_Text_C_Tips_Content = {Text = "Bônus"},
  PanelText_UI_Awaker_Item_Info_Text_C_Attribute_Content = {Text = "Atributos"},
  PanelText_UI_Awaker_Item_Info_Text_C_Attributes_Title_Content = {
    Text = "Atributos ."
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Configuration_Content = {
    Text = "Configuração da equipe"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Grade_Content = {Text = "Nível"},
  PanelText_UI_Awaker_Item_Info_Text_C_High_Content = {
    Text = "Mostrar atual"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Love_Content = {
    Text = "Taxa de Sincronização"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Love_Title_Content = {Text = "Afinidade"},
  PanelText_UI_Awaker_Item_Info_Text_C_Name1_Content = {Text = "Nome ."},
  PanelText_UI_Awaker_Item_Info_Text_C_Name2_Content = {Text = "Estilo ."},
  PanelText_UI_Awaker_Item_Info_Text_C_No_Content = {
    Text = "Não obtido"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Normal_Content = {
    Text = "Prévia de nível 60"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Potential_Content = {
    Text = "Aprofundamento Gnóstico"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Score_Content = {
    Text = "Pontuação ."
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Score_Force_Content = {
    Text = "Poder de combate"
  },
  PanelText_UI_Awaker_Item_Info_Text_C_Title_Content = {Text = "Reino"},
  PanelText_UI_Awaker_Item_Info_Text_C_Xx_Content = {
    Text = "Informações detalhadas"
  },
  PanelText_UI_Awaker_Item_List_3_Text_C_Full_Content = {
    Text = "Iluminar Completo"
  },
  PanelText_UI_Awaker_Item_List_3_Text_C_Got_Content = {Text = "Despertado"},
  PanelText_UI_Awaker_Item_List_Text_C_Already_Content = {Text = "Possuído"},
  PanelText_UI_Awaker_Item_List_Text_C_Disable_Content = {
    Text = "Não pode ser trocado"
  },
  PanelText_UI_Awaker_Item_List_Text_C_Full_Content = {
    Text = "Desenvolvimento da personalidade concluído"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Click_Content = {Text = "Retroceder"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Backtrace_Content = {Text = "Retroceder"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Click_Content = {
    Text = "Despertar Espiritual"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Enlightenment_Content = {
    Text = "Despertar Espiritual"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Click_Content = {Text = "Arquivo"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Information_Content = {Text = "Arquivo"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Michi_Click_Content = {Text = "Mystik"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Michi_Content = {Text = "Mystik"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Skill_Click_Content = {Text = "Habilidade"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Skill_Content = {Text = "Habilidade"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Click_Content = {Text = "Estado"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_State_Content = {Text = "Estado"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_TalentSelected_Content = {Text = "Talento"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Talent_Content = {Text = "Talento"},
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Click_Content = {
    Text = "Roda do destino"
  },
  PanelText_UI_Awaker_Item_Minihead_List_Text_C_Weapons_Content = {
    Text = "Roda do destino"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Consume_Content = {
    Text = "Desbloquear a forma primordial requer o consumo dos seguintes itens, você confirma?"
  },
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Name_1_Content = {Text = "Cancelar"},
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Name_2_Content = {Text = "Confirmar"},
  PanelText_UI_Awaker_Item_Origin_Tip_Text_C_Title_Content = {
    Text = "Confirmação de desbloqueio da forma primordial"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Common_Click_Content = {Text = "Geral"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Common_Content = {Text = "Geral"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Click_Content = {
    Text = "Modo de Tarefa"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Course_Content = {
    Text = "Modo de Tarefa"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Current_Content = {Text = "Atual"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Lower_Content = {
    Text = "Próximo nível"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Mad_Content = {
    Text = "Desbloqueio da explosão de loucura do limite"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Solved_Content = {
    Text = "Desbloqueado"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_Unsolved_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_MaxMad_WillSolved_Content = {
    Text = "Desbloqueio iminente"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Ranking_Content = {
    Text = "Prévia de aumento"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Skill_Story_Content = {
    Text = "Material de ativação"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Solved_Content = {
    Text = "Desbloqueado"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Click_Content = {
    Text = "Modo de Investigação"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Survey_Content = {
    Text = "Modo de Investigação"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Unsolved_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_Warning_CN_Content = {Text = "Ativado"},
  PanelText_UI_Awaker_Item_Potency_Detail_Text_C_WillSolved_Content = {
    Text = "Desbloqueio iminente"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Solved_Content = {
    Text = "Desbloqueado"
  },
  PanelText_UI_Awaker_Item_Potency_Detail_Text_MaxMad_Unsolved_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_1_Content = {
    Text = "Devolver o Blackpool"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Confirm_2_Content = {
    Text = "Rastreamento de criação"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_1_Content = {
    Text = "Pré-visualização de restauração"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_2_Content = {
    Text = "Pré-visualização de restauração"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_Preview_3_Content = {
    Text = "Pré-visualização de restauração"
  },
  PanelText_UI_Awaker_Item_Preview_Text_C_TipDesc_Content = {
    Text = "\"Regressão de desenvolvimento\" ou \"Regressão de despertar espiritual\" — após isso, não será mais possível realizar a \"Devolução da Piscina Negra\""
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Click_Content = {
    Text = "Modo de Tarefa"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Problem_Content = {
    Text = "Modo de Tarefa"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Special_Click_Content = {Text = "Especial"},
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Special_Content = {Text = "Especial"},
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Click_Content = {
    Text = "Modo de Investigação"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Survey_Content = {
    Text = "Modo de Investigação"
  },
  PanelText_UI_Awaker_Item_Skill_Detail_Text_C_Warning_CN_Content = {Text = "Ativado"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Attribute_Content = {Text = "Atributos"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Full_Content = {
    Text = "Limite de nível atingido"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_High_Content = {
    Text = "Mostrar atual"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Insufficient_Content = {
    Text = "Nível de despertador insuficiente para a ascensão"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Maniac_Content = {
    Text = "Fúria Explosiva"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Material_Content = {
    Text = "Consumir Materiais"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_1_Content = {Text = "Atual"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_2_Content = {Text = "Atual"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_3_Content = {
    Text = "Próximo nível"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Name_4_Content = {
    Text = "Próximo nível"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Normal_Content = {
    Text = "Prévia de nível máximo"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_PressTip_Content = {
    Text = "Mantenha pressionado a carta na mão para ampliar a visualização"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Skill_Tag_Content = {
    Text = "Fúria Explosiva"
  },
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Tale_Content = {Text = "História"},
  PanelText_UI_Awaker_Item_Skill_Training_Text_C_Text_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Attribute_Content = {Text = "Atributos"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Maniac_Content = {
    Text = "Fúria Explosiva"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Material_Content = {
    Text = "Consumir Materiais"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_1_Content = {Text = "Atual"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_2_Content = {Text = "Atual"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_3_Content = {
    Text = "Próximo nível"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Name_4_Content = {
    Text = "Próximo nível"
  },
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Tale_Content = {Text = "História"},
  PanelText_UI_Awaker_Item_Skill_Upgrades_Text_C_Text_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_C_Material_Content = {
    Text = "Consumir Materiais"
  },
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_C_Tips_Content = {
    Text = "Inserção automática"
  },
  PanelText_UI_Awaker_Item_Topped_DetailUp_Text_Confirm_Content = {Text = "Melhoria"},
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_2_Content = {
    Text = "Opção dois"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_3_Content = {
    Text = "Opção três"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Condition_Content = {
    Text = "Condições de Edificação"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Material_Content = {
    Text = "Materiais de Edificação"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_New_Content = {
    Text = "Mas ativa nova habilidade"
  },
  PanelText_UI_Awaker_Item_Topped_Detail_Text_C_Title_Content = {
    Text = "Condições de Edificação<WordSize20:(escolha um)>"
  },
  PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Prop_Title_Content = {Text = "Atributos"},
  PanelText_UI_Awaker_Item_Trinket_Change_Text_C_Tips_Content = {
    Text = "Informações detalhadas"
  },
  PanelText_UI_Awaker_Item_Trinket_Detail_Text_C_Empty_Content = {
    Text = "Por favor, escolha o equipamento de pacto"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Deplete_Content = {
    Text = "Consumir Materiais"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Fast_Content = {
    Text = "Inserção rápida"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_1_Content = {Text = "Melhoria"},
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_2_Content = {
    Text = "Transcrição"
  },
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Name_3_Content = {Text = "Melhoria"},
  PanelText_UI_Awaker_Item_Trinket_Refinement_Text_C_Refinement_Content = {
    Text = "Detalhes do pacto"
  },
  ["PanelText_UI_Awaker_Item_Voice_Text_C_ Voice_Content"] = {
    Text = "Dublado Por ."
  },
  PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Normal_Content = {Text = "Batalha"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Battle_Select_Content = {Text = "Batalha"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Daily_Normal_Content = {Text = "Rotina"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Daily_Select_Content = {Text = "Rotina"},
  PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Normal_Content = {
    Text = "Fase de Duelo"
  },
  PanelText_UI_Awaker_Item_Voice_Text_C_Pvp_Select_Content = {
    Text = "Fase de Duelo"
  },
  PanelText_UI_Awaker_Item_Weapon_Refine_Text_C_Coin_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Blackpool_Content = {
    Text = "Voltar à pré-visualização"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_3_Content = {
    Text = "Devolver o Blackpool"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Confirm_4_Content = {
    Text = "Reversão de empilhamento"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Cost_Content = {
    Text = "Consumir Materiais"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Current_Content = {
    Text = "Efeito atual"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Expend_Content = {
    Text = "Consumir Materiais"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Fast_Content = {
    Text = "Inserção rápida"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Full_Content = {
    Text = "Nível máximo"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_1_Content = {Text = "Atual"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_2_Content = {Text = "Atual"},
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_3_Content = {
    Text = "Após empilhamento"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_4_Content = {
    Text = "Após empilhamento"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_5_Content = {
    Text = "Próximo estágio"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Name_6_Content = {
    Text = "Próximo estágio"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Next_Content = {
    Text = "<Blue:Próximo efeito>"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Overlay_Content = {
    Text = "Voltar à pré-visualização"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Level_Content = {
    Text = "Nível de acúmulo da roda do destino"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Refine_Name_Content = {
    Text = "Posição sobreposta"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Title_Content = {
    Text = "Escolha material de empilhamento"
  },
  PanelText_UI_Awaker_Item_Weapon_Refining_Text_C_Warning_Content = {
    Text = "Limite de nível de empilhamento atingido"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_BackTraceTip_Content = {
    Text = "Após usar \"Reversão de empilhamento\", não será mais possível realizar \"Devolução da Piscina Negra\"."
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen2_Text_C_Title_Content = {
    Text = "Detalhes da roda do destino"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Click_Content = {Text = "Retroceder"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Backtrack_Content = {Text = "Retroceder"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Breakthrough_Content = {Text = "Edificar"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Enhance_Content = {Text = "Reforço"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Equip_Content = {Text = "Equipando"},
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Fast_Content = {
    Text = "Colocação rápida"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_1_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Refine_Content = {
    Text = "Posição sobreposta"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Click_Content = {
    Text = "Posição sobreposta"
  },
  PanelText_UI_Awaker_Item_Weapon_Strengthen_Text_C_Skill_Content = {
    Text = "Posição sobreposta"
  },
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Message_Content = {
    Text = "Informações do Despertar"
  },
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Story_Content = {Text = "História"},
  PanelText_UI_Awaker_PanelStory_Main_Text_C_Title_Content = {
    Text = "Informações básicas"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_1_Content = {
    Text = "Forma comum"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_2_Content = {
    Text = "Forma comum"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Ordinary_3_Content = {
    Text = "Forma comum"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_1_Content = {
    Text = "Forma de Gênesis"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_2_Content = {
    Text = "Forma de Gênesis"
  },
  PanelText_UI_Awaker_Panel_Main_Text_C_Origin_3_Content = {
    Text = "Forma de Gênesis"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Null_Content = {
    Text = "Nenhum pacto disponível para a parte atual"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Strengthen_Content = {Text = "Reforço"},
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_Title_Content = {
    Text = "Imobilização de Mystik"
  },
  PanelText_UI_Awaker_Panel_Trinket_BindDetail_Text_C_UnBindAll_Content = {
    Text = "Desvincular Tudo"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Contrast_Content = {Text = "Comparar"},
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info1_Content = {
    Text = "Apreender o Destino"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info2_Content = {
    Text = "Roda do Destino"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_C_Info3_Content = {
    Text = "Roda do Destino"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty1_Content = {
    Text = "Escolha de equipamento de roda de destino à esquerda"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Empty_Content = {
    Text = "Escolha de equipamento de roda de destino à esquerda"
  },
  PanelText_UI_Awaker_Panel_Weapon_Main_Text_Unlock_Content = {
    Text = "Edificação do Despertar\nDesbloquear a segunda Roda do Destino"
  },
  PanelText_UI_Awaker_Popup_Attribute_Detail_Text_C_Title_Content = {
    Text = "Detalhes dos atributos"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_1_Content = {
    Text = "Ver detalhes"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Name_2_Content = {Text = "Confirmar"},
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_NoTask_Content = {
    Text = "Nenhum item recuperável disponível"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Title_Content = {
    Text = "Escolha alvo de retrocesso"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_1_Content = {
    Text = "Despertador permanente"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_2_Content = {
    Text = "Despertador especial"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_C_Toggle_3_Content = {
    Text = "Roda do destino"
  },
  PanelText_UI_Awaker_Popup_Backtrace_Tip_Text_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_BindTip_Content = {
    Text = "Os Mystiks equipados por outros Corpos Despertos ou presentes em formações/planos/suporte foram removidos automaticamente"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Tip_Content = {
    Text = "Confirmar a imobilização do seguinte Mystik?"
  },
  PanelText_UI_Awaker_Popup_BindTrinket_Text_C_Title_Content = {
    Text = "Confirmação de Modificação de Atar"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_C_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Cancel_Name_Content = {Text = "Cancelar"},
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Confirm_Name_Content = {Text = "Confirmar"},
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Tip_Content = {
    Text = "Materiais necessários atualmente insuficientes. Deseja consumir os seguintes materiais para completar?"
  },
  PanelText_UI_Awaker_Popup_Exchange_Tip_Text_Title_Content = {
    Text = "Dica de preenchimento"
  },
  PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Expired_Content = {
    Text = "Os seguintes itens expiraram e não podem ser usados"
  },
  PanelText_UI_Awaker_Popup_Expired_Tip_Text_C_Title_Content = {
    Text = "Item expirado"
  },
  PanelText_UI_Awaker_Popup_Jewelry_Text_C_No_Trinket_Content = {
    Text = "Sem materiais selecionáveis"
  },
  PanelText_UI_Awaker_Popup_Jewelry_Text_C_Title_Content = {
    Text = "Escolha pacto"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Content_Content = {
    Text = "Até o limite"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Title_Content = {
    Text = "Aumento de nível"
  },
  PanelText_UI_Awaker_Popup_Levelup_Tip_Text_C_Xuyao_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Awaker_Popup_MyTeam_List_Text_C_William_Content = {
    Text = "Sem materiais de upgrade"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Coin_Count_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Material_Content = {
    Text = "Consumir Materiais"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Name_Content = {
    Text = "Aprofundamento Gnóstico"
  },
  PanelText_UI_Awaker_Popup_Potential_Text_C_Title_Content = {
    Text = "Aumento do limite de nível"
  },
  PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Preview_Content = {
    Text = "Após retroceder, você receberá os seguintes materiais"
  },
  PanelText_UI_Awaker_Popup_Preview_Tip_Text_C_Title_Content = {
    Text = "Pré-visualização de restauração"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Content_Content = {
    Text = "Limite de nível"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Title_Content = {
    Text = "Aprimoramento de Habilidade"
  },
  PanelText_UI_Awaker_Popup_Skillup_Tip_Text_C_Xuyao_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Condition_Content = {
    Text = "Condições de desbloqueio"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Current_Content = {Text = "Atual"},
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_High_Content = {
    Text = "Mostrar atual"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Lower_Content = {
    Text = "Próximo nível"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_C_Normal_Content = {
    Text = "Pré-visualização de nível máximo"
  },
  PanelText_UI_Awaker_Popup_Talent_Main_Text_Require_Content = {
    Text = "Consumir Materiais"
  },
  PanelText_UI_Awaker_Popup_Tip_Preview_Text_C_Title_Content = {
    Text = "Pré-visualização de Materiais de Edificação"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_Info_Content = {
    Text = "Clique no espaço em branco para fechar"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_New_Content = {
    Text = "Mas ativa nova habilidade"
  },
  PanelText_UI_Awaker_Popup_Tip_Succeed_Text_C_Succeed_Content = {
    Text = "Edificação bem-sucedida"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Breakthrough_Content = {
    Text = "Requisito de Sincronização"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Now_Content = {Text = "Atual"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Reward_Content = {
    Text = "Recompensa de nível"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Screening_Content = {
    Text = "Recompensa Recebida"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Tips_Content = {Text = "Ver"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Title_Content = {
    Text = "Taxa de Sincronização"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_Unlock_Content = {
    Text = "Desbloqueio de Arquivo"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_C_illustrate_Content = {Text = "Regras"},
  PanelText_UI_Awaker_Popup_Topped_Tip2_Text_Name_Content = {Text = "Receber"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Activation_Content = {Text = "Ativado"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Lv_Content = {
    Text = "Aumento do limite de nível"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Content = {
    Text = "Aumento do limite de nível"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Mad_Name_Content = {
    Text = "Explosão Superalimentada"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Activation_Content = {Text = "Ativado"},
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_MaxMad_Name_Content = {
    Text = "Regra Final"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_Activation_Content = {
    Text = "Não ativado"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Not_MaxMad_Activation_Content = {
    Text = "Não ativado"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Solved_Content = {
    Text = "Desbloqueado"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Title_Content = {
    Text = "Desenvolvimento da personalidade"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unlock_Content = {
    Text = "Aumento de atributos"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_Unsolved_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip3_Text_C_WillSolved_Content = {
    Text = "Desbloqueio iminente"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Material_Content = {
    Text = "Materiais de Edificação"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Reward_Content = {
    Text = "Recompensa da Edificação"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_C_Title_Content = {
    Text = "Pré-visualização de Edificação"
  },
  PanelText_UI_Awaker_Popup_Topped_Tip_Text_Screening_Content = {
    Text = "Recompensa Recebida"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_BindTip_Content = {
    Text = "Após vincular, o atributo principal do Mystik é aumentado em 50% adicionais!"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Bind_Content = {
    Text = "Imobilização de Mystik"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Empty_Suit_Content = {
    Text = "Sem efeitos de conjunto ativos"
  },
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Foundation_Content = {Text = "Atributos"},
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Rule_Content = {Text = "Regras"},
  PanelText_UI_Awaker_Popup_Trinket_Bind_Text_C_Suit_Content = {
    Text = "Efeito do Conjunto"
  },
  PanelText_UI_Awaker_Popup_Trinket_Change_Text_C_Equipped_Content = {Text = "Equipado"},
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_AutoRefinement_Content = {
    Text = "Transcrição Automática"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Empty_Content = {
    Text = "Clique para transcrever e obter novo subatributo"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Exchange_Content = {
    Text = "Substituição de configuração"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Foundation_Content = {
    Text = "Atributo Secundário Primordial"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Hoist_Content = {
    Text = "Novo subatributo"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_1_Content = {
    Text = "Transcrição"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Name_2_Content = {Text = "Substituir"},
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_No_Entries_Content = {
    Text = "Sem atributos"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Skip_Content = {
    Text = "Pular animação"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_Text_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Awaker_Popup_Trinket_Conversion_Text_C_illustrate_Content = {
    Text = "Instruções de transcrição"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Filtrate_Content = {
    Text = "Materiais de nível SSR ou inferior"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Shortcut_Content = {
    Text = "Inserção rápida"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_Detail_Text_C_Upper_Limit_Content = {
    Text = "Limite de nível atingido"
  },
  PanelText_UI_Awaker_Popup_Trinket_Intensify_List_Text_C_None_Content = {
    Text = "Sem destino não equipado"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_1_Content = {
    Text = "Por favor, escolha o equipamento de pacto"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Empty_2_Content = {
    Text = "Sem efeitos de conjunto ativos"
  },
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Foundation_Content = {Text = "Atributos"},
  PanelText_UI_Awaker_Popup_Trinket_Main3_Text_C_Suit_Content = {
    Text = "Efeito do Conjunto"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Contrast_Content = {Text = "Comparar"},
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Empty_Content = {
    Text = "Por favor, escolha o equipamento de pacto"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_None_Content = {
    Text = "Nenhum pacto disponível para a parte atual"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Notselected_Content = {
    Text = "Por favor, escolha o equipamento de pacto"
  },
  PanelText_UI_Awaker_Popup_Trinket_Replace_Text_C_Suit_Content = {
    Text = "Efeito do Conjunto"
  },
  PanelText_UI_Awaker_Popup_Trinket_Select_List_Text_C_None_Content = {
    Text = "Sem pacto não equipado"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Consume_Content = {
    Text = "Consumir Materiais"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Deplete_Content = {
    Text = "Consumir Materiais"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Exchange_Content = {
    Text = "Substituição de configuração"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Content = {
    Text = "Inserção rápida"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_High_Content = {
    Text = "Subir 1 nível"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Fast_Normal_Content = {
    Text = "Subir 1 nível"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_MaxLevel_Content = {Text = "Reforço"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_High_Content = {
    Text = "Suba de nível até o máximo"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Max_Normal_Content = {
    Text = "Suba de nível até o máximo"
  },
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Name_3_Content = {Text = "Melhoria"},
  PanelText_UI_Awaker_Popup_Trinket_Upgrade_Text_C_Title_Content = {Text = "Nível"},
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_AutoSelect_Content = {
    Text = "Seleção Automática"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Cancel_Content = {Text = "Cancelar"},
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Confirm_Content = {
    Text = "Desvincular Mystik"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_NeedTrinket_Content = {
    Text = "Mystik Necessário"
  },
  PanelText_UI_Awaker_Popup_UnBindTrinket_Text_C_Title_Content = {
    Text = "Desvincular Mystik"
  },
  PanelText_UI_Awaker_Popup_Whole_Body_Text_C_Reveal_Content = {Text = "Esconder"},
  PanelText_UI_Awaker_Popup_illustrate_Tips_Text_C_Title_Content = {
    Text = "Descrição do Sufixo"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Tips_Content = {
    Text = "Visão geral"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Title_Content = {
    Text = "Talento do Despertado"
  },
  PanelText_UI_Awaker_Special_Skill_Main_Text_C_Type_Content = {Text = "Tipo"},
  PanelText_UI_Awaker_Weapon_Enhance_Success_Text_C_Succeed_Content = {
    Text = "Reforço bem-sucedido"
  },
  PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Info_Content = {
    Text = "Clique no espaço em branco para fechar"
  },
  PanelText_UI_Awaker_Weapon_Refine_Success_Text_C_Succeed_Content = {
    Text = "Empilhamento bem-sucedido"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Attribute_Content = {Text = "Atributos"},
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Choose_Content = {
    Text = "·Escolha o Despertar"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Helicopter_Content = {
    Text = "·Prévia de Amplificação"
  },
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Skill_Content = {Text = "Habilidade"},
  PanelText_UI_Bag_Helicopter_Tips_Text_C_Title_Content = {
    Text = "Amplificação do Despertado"
  },
  PanelText_UI_Bag_Item_Appearance_Text_C_Got_Content = {Text = "Obtido"},
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_AavtarName_Content = {
    Text = "Avatar e Expressão"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Avatar_Info_Content = {
    Text = "Prévia de detalhes"
  },
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Source_Content = {Text = "Origem"},
  PanelText_UI_Bag_Item_Detail_Optimized_Text_C_Time_Content = {
    Text = "Tempo restante válido:"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_AavtarName_Content = {
    Text = "Avatar e Expressão"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Avatar_Info_Content = {
    Text = "Prévia de detalhes"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_KeeperSkill_Title_Content = {
    Text = "Efeito da Chave:"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Source_Content = {
    Text = "Obter origem"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Time_Content = {
    Text = "Tempo restante válido"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Attack_Content = {
    Text = "Ataque base"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Defense_Content = {
    Text = "Defesa Básica"
  },
  PanelText_UI_Bag_Item_Detail_Text_C_Weapon_Physique_Content = {
    Text = "Constituição base"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Full_Content = {
    Text = "Iluminar Completo"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Title_Content = {
    Text = "Escolha fragmento de despertar"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_C_Yes_Content = {Text = "Possuído"},
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Cancel_Name_Content = {
    Text = "Ver detalhes"
  },
  PanelText_UI_Bag_Obtain_Awaken_Tips_Text_Confirm_Name_Content = {Text = "Confirmar"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_BtnName_Content = {Text = "Receber"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Emoji_Content = {Text = "expressão"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Head_Content = {Text = "Avatar"},
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_NoTask_Content = {
    Text = "Todas as aparências obtidas"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_RatePreview_Content = {
    Text = "Prévia de Probabilidade"
  },
  PanelText_UI_Bag_Panel_AppearancePreview_Text_C_Title_Content = {
    Text = "Prévia de Aparência"
  },
  PanelText_UI_Bag_Panel_Main_Text_AmountName_Content = {Text = "Quantidade"},
  PanelText_UI_Bag_Panel_Main_Text_C_2_Select_Content = {Text = "Ordem"},
  PanelText_UI_Bag_Panel_Main_Text_C_Cap_Content = {
    Text = "Fortalecido até o limite atual de nível"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_None2_Content = {
    Text = "Inventário vazio"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_NormotopiaCap_Content = {
    Text = "Limite de empilhamento atingido"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_Replacement_Content = {
    Text = "Substituição"
  },
  PanelText_UI_Bag_Panel_Main_Text_C_Resolve_Content = {Text = "Desmontar"},
  PanelText_UI_Bag_Panel_Main_Text_C_Synthesis_Content = {Text = "Síntese"},
  PanelText_UI_Bag_Panel_Main_Text_C_recast_Content = {Text = "Reforjar"},
  PanelText_UI_Bag_Panel_Main_Text_Intensify_Content = {Text = "Reforço"},
  PanelText_UI_Bag_Panel_Main_Text_Normotopia_Content = {
    Text = "Posição sobreposta"
  },
  PanelText_UI_Bag_Panel_Main_Text_Title_Content = {
    Text = "Inventário"
  },
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_BtnName_Content = {Text = "Receber"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Emoji_Content = {Text = "expressão"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Head_Content = {Text = "Avatar"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_NoTask_Content = {Text = "Sem dados"},
  PanelText_UI_Bag_Panel_OptionalAppearance_Text_C_Title_Content = {
    Text = "Prévia de Aparência"
  },
  PanelText_UI_Battle_Item_CounterAwaker_Text_C_CounterAwaker_Content = {
    Text = "Despertado de Ataque Especial"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Disabled_CN_Content = {Text = "Confi rmar"},
  PanelText_UI_Battle_Panel_CardStack_Text_C_Display_Content = {
    Text = "Mostrar cartão"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_Hide_Content = {
    Text = "Cartão Oculto"
  },
  PanelText_UI_Battle_Panel_CardStack_Text_C_High_CN_Content = {Text = "Confi rmar"},
  PanelText_UI_Battle_Panel_CardStack_Text_C_Normal_CN_Content = {Text = "Confi rmar"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Count_Content = {Text = "D-tide"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_End_EN_No_Content = {Text = "Fim"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Insufficient_Content = {
    Text = "Espaço insuficiente"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_Name_Content = {Text = "Fim"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Setting_Content = {
    Text = "Configurações"
  },
  PanelText_UI_Battle_Panel_Dbg_Text_C_Unclickable_Content = {Text = "Fim"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_Zongshanghai_Content = {Text = "Dano Total"},
  PanelText_UI_Battle_Panel_Dbg_Text_C_insufficient_Content = {
    Text = "Espaço insuficiente"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_CD_Content = {Text = "Resfriando"},
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Cooling_Content = {
    Text = "Resfriando, pode usar novamente no próximo turno"
  },
  PanelText_UI_Battle_Popup_Anger_Overrun_Text_C_Title_Content = {
    Text = "Explosão Superalimentada"
  },
  PanelText_UI_Battle_Popup_Anger_Text_C_CD_Content = {Text = "Resfriando"},
  PanelText_UI_Battle_Popup_Anger_Text_C_Cooling_Content = {
    Text = "Resfriando, pode usar novamente no próximo turno"
  },
  PanelText_UI_Battle_Popup_Anger_Text_Title_Content = {
    Text = "Fúria Explosiva"
  },
  PanelText_UI_Battle_Popup_AttachPost_Text_C_AttachPost_Content = {
    Text = "Perseguição"
  },
  PanelText_UI_Battle_Popup_CardGroup_Text_C_Confirm_Content = {Text = "Confirmar"},
  PanelText_UI_Battle_Popup_CardGroup_Text_C_Title_Content = {
    Text = "Selecione um Conjunto de Cartas"
  },
  PanelText_UI_Battle_Popup_Elite_Text_C_Victory_Content = {
    Text = "Alerta de Perigo"
  },
  PanelText_UI_Battle_Popup_Elite_Tips_Text_C_Hang_Content = {
    Text = "Batalha - Começar"
  },
  PanelText_UI_Battle_Popup_Elite_Tips_Text_C_Title_Content = {
    Text = "Alerta máximo"
  },
  PanelText_UI_Battle_Popup_Fail_Text_C_Continue_Content = {
    Text = "Clique para continuar"
  },
  PanelText_UI_Battle_Popup_Fail_Text_C_Victory_Content = {
    Text = "Derrota na batalha"
  },
  PanelText_UI_Battle_Popup_Furnace_Text_C_Name_1_Content = {Text = "Cancelar"},
  PanelText_UI_Battle_Popup_Furnace_Text_C_Name_2_Content = {Text = "Confirmar"},
  PanelText_UI_Battle_Popup_Furnace_Text_C_Title_Content = {
    Text = "Fornalha carmesim"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Awaker_School_Content = {Text = "Guardião"},
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Nature_Content = {
    Text = "Informações da equipe"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Property_Content = {
    Text = "Suprimentos de emergência"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill2_Content = {
    Text = "Energia da Chave de Prata"
  },
  PanelText_UI_Battle_Popup_Keeper_Skill_Tip_Text_C_Skill_Tag_Content = {
    Text = "Ordem de chave"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeeperSkill_Content = {Text = "Libere"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenAwaken_Content = {Text = "Libere"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_C_KeyTokenNewChaos_Content = {Text = "Libere"},
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Text_Title_Content = {
    Text = "Escolha um comando"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_AwakenTitle_Content = {
    Text = "Despertar da Chave de Prata"
  },
  PanelText_UI_Battle_Popup_KeyTokenAwaken_Txt_C_NewChaosTitle_Content = {
    Text = "Ordem de chave composta"
  },
  PanelText_UI_Battle_Popup_Open_Tips_Text_C_Hang_Content = {
    Text = "Batalha - Começar"
  },
  PanelText_UI_Battle_Popup_Open_Tips_Text_C_Title_Content = {
    Text = "Início da Batalha"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips2_Content = {
    Text = "Realizar a troca?"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_CostTips_Content = {
    Text = "Usos da Entidade de Conhecimento de Emergência esgotados. Deseja gastar?"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_Cost_Content = {Text = "Consumo"},
  PanelText_UI_Battle_Popup_RebirthTip_Text_C_Tips_Content = {
    Text = "(Ao resgatar, será consumido imediatamente e você reviverá. Se recuar, o Corpo de Conhecimento de Emergência será devolvido)"
  },
  PanelText_UI_Battle_Popup_RebirthTip_Text_Cancel_Name_Content = {Text = "Cancelar"},
  PanelText_UI_Battle_Popup_RebirthTip_Text_Confirm_Name_Content = {Text = "Confirmar"},
  PanelText_UI_Battle_Popup_RebirthTip_Text_Title_Content = {
    Text = "Confirmação de Ressurreição"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_AffixInfo_Content = {
    Text = "Descrição do Sufixo"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Arousal_Content = {Text = "Despertar"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Deepen_Tag_Content = {
    Text = "Desenvolvimento da personalidade"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Destiny_Content = {
    Text = "Roda do destino"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Gnosisi_Content = {
    Text = "Despertar do Conhecimento Espiritual"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Maniac_Content = {
    Text = "Valor de loucura"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Property_Content = {
    Text = "Detalhes dos atributos"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Secret_Content = {Text = "Mystik"},
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Skill_Tag_Content = {
    Text = "Fúria Explosiva"
  },
  PanelText_UI_Battle_Popup_Record_Tip_New_Text_C_Talent_Content = {Text = "Talento"},
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Awakening_Content = {
    Text = "Despertar do Conhecimento Espiritual"
  },
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Trinket_Content = {Text = "Mystik"},
  PanelText_UI_Battle_Popup_Record_Tip_Text_C_Title_Weapon_Content = {
    Text = "Roda do destino"
  },
  PanelText_UI_Battle_Popup_Round_Enemy_Text_C_Our_Content = {
    Text = "Ação do inimigo"
  },
  PanelText_UI_Battle_Popup_Round_Mine_Text_C_Our_Content = {
    Text = "Ação do nosso lado"
  },
  PanelText_UI_Battle_Popup_SelectAwaker_Text_C_Title_Content = {
    Text = "Escolha um Despertado"
  },
  PanelText_UI_Battle_Popup_Settle_Text_C_Succeed_Content = {
    Text = "Batalha vencida"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Activate_Content = {
    Text = "Comando atual"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Defense_Content = {Text = "Defesa"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_1_Content = {
    Text = "Não pode selecionar"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Disable_2_Content = {
    Text = "Não pode selecionar"
  },
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Frantic_Content = {Text = "Loucura"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Name_Content = {Text = "Batalha"},
  PanelText_UI_Battle_ShenHai_Switch_Text_C_Title_Content = {
    Text = "Escolha a postura do tentáculo"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Cancel_Content = {Text = "Cancelar"},
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Lock_Content = {
    Text = "Inversão Temporal: Retroceda o combate para um turno anterior"
  },
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Sure_Content = {Text = "Confirmar"},
  PanelText_UI_Battle_Tip_Backtrack_Text_C_Title_Content = {
    Text = "Inversão Temporal"
  },
  PanelText_UI_Battle_Tip_CounterAwaker_Text_C_Title_Content = {
    Text = "Estado do inimigo"
  },
  PanelText_UI_Card_Panel_Discard_Text_C_Title_Content = {
    Text = "Monte de cartas"
  },
  PanelText_UI_Chaper_Popup_Award_Optimized_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_Title_Content = {
    Text = "Recompensa acumulada"
  },
  PanelText_UI_Chaper_Popup_Award_Text_C_Title_En_Content = {Text = "Pode obter"},
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Cancel_Content = {Text = "Sair"},
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Confirm_Content = {
    Text = "Ainda investigar"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Joinin_Content = {
    Text = "Sugiro concluir a seguinte fase de investigação"
  },
  PanelText_UI_Chaper_Popup_BsetPlot_Text_C_Screening_Content = {
    Text = "Não avisar mais hoje"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Activity_Bright_Content = {Text = "Gravura"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Activity_Content = {Text = "Gravura"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Begone_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Creation_Content = {Text = "Criação"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Darkactivity_Content = {Text = "Gravura"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Darkgame_Content = {Text = "Criação"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Demon_Content = {
    Text = "Nenhuma oração disponível"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Game_Bright_Content = {Text = "Criação"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Game_Content = {Text = "Criação"},
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Mail_Content = {
    Text = "Nenhum Relicário"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_No_Content = {
    Text = "Nenhuma Gravação"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Not_Content = {
    Text = "Sem criações"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_Walk_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Chaper_Popup_Detailed_Text_C_mail_Content = {
    Text = "Caixa de correio vazia"
  },
  PanelText_UI_Chaper_Popup_Level_Success_Text_C_Title_Content = {
    Text = "Conquista da fase"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Achievement_Content = {
    Text = "Prévia do inimigo"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Cost_Tips_Content = {
    Text = "Requisitos da equipe:"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Grade_Content = {
    Text = "Nível recomendado"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Monster_Content = {
    Text = "Criações da fase"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Recommend_Content = {
    Text = "Recomendação de Domínio"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Reward_Content = {
    Text = "Prévia da Recompensa"
  },
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Suppress_Content = {Text = "D-tide"},
  PanelText_UI_Chaper_Popup_Particulars_New_Text_C_Title_Content = {
    Text = "Prévia da Recompensa"
  },
  PanelText_UI_Chaper_Popup_Particulars_Text_C_Monster_Content = {Text = "monstro"},
  PanelText_UI_Chaper_Popup_Particulars_Text_C_Title_Content = {
    Text = "Prévia da Recompensa"
  },
  PanelText_UI_Chaper_Popup_Particulars_View_Text_C_Replay_Content = {Text = "Lembre-se"},
  PanelText_UI_Chaper_Popup_StageAchieve_View_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Chapter_Dream_View_Text_C_Difficulty_Content = {
    Text = "Dificuldade"
  },
  PanelText_UI_Chapter_Dream_View_Text_C_Nightmare_Content = {Text = "Loucura"},
  PanelText_UI_Chapter_Dream_View_Text_C_Remember_Content = {Text = "Lembrança"},
  PanelText_UI_Chapter_Dream_View_Text_C_Simple_Content = {Text = "Comum"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Difficulty_Content = {
    Text = "Dificuldade"
  },
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Nightmare_Content = {Text = "Pesadelo"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Remember_Content = {Text = "Lembrança"},
  PanelText_UI_Chapter_Hard_Swich_Group_New_Text_C_Simple_Content = {Text = "Fácil"},
  PanelText_UI_Chapter_Item_Achievement_List_Text_C_Lost_Content = {
    Text = "Não alcançado"
  },
  PanelText_UI_Chapter_Item_Achievement_List_Text_Lost_Content = {
    Text = "Não alcançado"
  },
  PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Expect_Content = {Text = "Aguarde"},
  PanelText_UI_Chapter_Item_Chapter_Big_Text_C_Tips_Content = {Text = "Completar"},
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect1_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect2_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Expect_Content = {Text = "Aguarde"},
  PanelText_UI_Chapter_Item_Chapter_Small_Text_C_Tips_Content = {Text = "Completar"},
  PanelText_UI_Chapter_Item_Dream_01_Text_C_Chaoter_Content = {
    Text = "Paisagem dos Sonhos"
  },
  PanelText_UI_Chapter_Item_Dream_01_Text_C_Free_Unlock_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Chapter_Item_Dream_02_Text_C_Free_Unlock_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Chapter_Item_Dream_03_Text_C_Free_Unlock_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Chapter_Item_Dream_04_Text_C_Free_Unlock_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Chapter_Item_Dream_05_Text_C_Chaoter_Content = {
    Text = "Paisagem dos Sonhos"
  },
  PanelText_UI_Chapter_Item_Dream_05_Text_C_Free_Unlock_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Chapter_Item_Skill_Text_C_Level_Content = {Text = "Estado"},
  PanelText_UI_Chapter_Item_Special_01_Text_C_Chaoter_Content = {
    Text = "Paisagem dos Sonhos"
  },
  PanelText_UI_Chapter_Item_Special_01_Text_C_Free_Unlock_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Chapter_Item_Special_02_Text_C_Free_Unlock_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Chapter_Item_Special_03_Text_C_Free_Unlock_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Chapter_Item_StageAchieve_Text_C_Lost_Content = {
    Text = "Não alcançado"
  },
  PanelText_UI_Chapter_Item_Success_List_Text_Lost_Content = {
    Text = "Não alcançado"
  },
  PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Award_Content = {
    Text = "Todas as condições de recompensa foram cumpridas"
  },
  PanelText_UI_Chapter_Panel_Main2_ItemBranch_Text_C_Free_Unlock_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Award_Content = {Text = "Concluído"},
  PanelText_UI_Chapter_Panel_Main2_SmallBranch_Text_C_Free_Unlock_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Difficulty_Content = {
    Text = "Dificuldade"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Nightmare_Content = {Text = "Loucura"},
  PanelText_UI_Chapter_Panel_Main2_Text_C_NoTask_Content = {
    Text = "Sem registros de missões especiais"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Simple_Content = {Text = "Comum"},
  PanelText_UI_Chapter_Panel_Main2_Text_C_Time_Content = {
    Text = "Novo em 21/12/2023 às 05:00, fique ligado"
  },
  PanelText_UI_Chapter_Panel_Main2_Text_C_Title_Content = {
    Text = "Investigação"
  },
  PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_2_Content = {
    Text = "Conquista da fase"
  },
  PanelText_UI_Chapter_Panel_Main_Text_C_Tishi_Content = {
    Text = "Pontuação da fase"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_01_Content = {
    Text = "Dificuldade"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Content = {
    Text = "Dificuldade"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Difficulty_Now_Content = {
    Text = "Dificuldade"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_01_Content = {Text = "Loucura"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Content = {Text = "Loucura"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Nightmare_Now_Content = {Text = "Loucura"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Progress_Content = {
    Text = "Progresso da Investigação"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_01_Content = {Text = "Comum"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_Content = {Text = "Comum"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Simple_Now_Content = {Text = "Comum"},
  PanelText_UI_Chapter_Panel_Spur_Text_C_Tab_Special_Content = {
    Text = "Evento por tempo limitado"
  },
  PanelText_UI_Chapter_Panel_Spur_Text_C_Tishi_Content = {
    Text = "Conquista da fase"
  },
  PanelText_UI_Chapter_Popup_Achievement_Text_C_Title_Content = {Text = "Conquistas"},
  PanelText_UI_Chapter_Popup_Chapter_Text_C_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Chapter_Popup_Monster_Details_Text_C_Title_Content = {
    Text = "Detalhes do inimigo"
  },
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Effect_Content = {Text = "Efeito"},
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Chapter_Popup_Vibes_List_Text_C_Story_Content = {Text = "História"},
  PanelText_UI_Chapter_Popup_Yuanxing_Text_Title_Content = {
    Text = "Avaliação de Investigação"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Difficulty_Content = {
    Text = "Dificuldade"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Nightmare_Content = {Text = "Loucura"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Progress_Content = {
    Text = "Progresso de coleta"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Remember_Content = {Text = "Lembrança"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Simple_Content = {Text = "Comum"},
  PanelText_UI_Chapter_Special_Spur_View_Text_C_Tab_Special_Content = {
    Text = "Evento por tempo limitado"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Difficulty_Content = {
    Text = "Dificuldade"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Nightmare_Content = {Text = "Loucura"},
  PanelText_UI_Chapter_Spur_View_Text_C_Progress_Content = {
    Text = "Progresso de coleta"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Remember_Content = {Text = "Lembrança"},
  PanelText_UI_Chapter_Spur_View_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Chapter_Spur_View_Text_C_Review_Content = {Text = "Prólogo"},
  PanelText_UI_Chapter_Spur_View_Text_C_Simple_Content = {Text = "Comum"},
  PanelText_UI_Chapter_Spur_View_Text_C_Tab_Special_Content = {
    Text = "Evento por tempo limitado"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Condition_Content = {
    Text = "não atende às condições de desbloqueio"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Name_Content = {
    Text = "Entrar na história"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_NoTask_Content = {
    Text = "Fervor de Procriação ainda não desbloqueado"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_StoryDesc_Content = {
    Text = "À medida que \"onda de desejo\" continua, os despertadores foram afetados por poderes misteriosos, caindo em um estado de \"febre reprodutiva\"... Cuidem-se, guardiões!"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Tip_Content = {
    Text = "Durante o evento \"onda de desejo\", haverá um desconto por tempo limitado, permitindo ignorar os requisitos de afinidade e desbloquear o evento correspondente utilizando apenas \"pontos de partida da realidade\"*1!"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_C_Title_Content = {
    Text = "Convite para a festa"
  },
  PanelText_UI_Chapter_Vindicate_View_Text_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Collection_History_Details_Text_C_Lock_Content = {
    Text = "Material de imagem ainda não obtido"
  },
  PanelText_UI_Collection_History_Details_Text_Title_Content = {Text = "Registro"},
  PanelText_UI_Collection_Item_Comprehensive_Text_C_Placeholder_Content = {
    Text = "Procurar substantivo"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_High_Content = {
    Text = "Retroceder Música de Fundo"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Label_Content = {Text = "fonógrafo"},
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Mail_Content = {
    Text = "Progresso de coleta"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Normal_Content = {
    Text = "Definir como música de fundo"
  },
  PanelText_UI_Collection_Item_Music_Alone_Text_C_Title_Content = {Text = "Biblioteca"},
  PanelText_UI_Collection_Item_Music_Text_C_Label_Content = {Text = "fonógrafo"},
  PanelText_UI_Collection_Item_Music_Text_C_Mail_Content = {
    Text = "Progresso de coleta"
  },
  PanelText_UI_Collection_Item_Music_Text_C_Title_Content = {Text = "Biblioteca"},
  PanelText_UI_Collection_Item_Music_Toggle_Text_C_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Collection_Item_Music_Toggle_Text_C_UnLock_Content = {
    Text = "Desbloquear"
  },
  PanelText_UI_Collection_Item_Video_Text_C_UnLock_Content = {
    Text = "Desbloquear"
  },
  PanelText_UI_Collection_Panel_EquipDetail_Text_C_Title_Content = {Text = "História"},
  PanelText_UI_Collection_Panel_Equip_Text_C_None2_Content = {
    Text = "Ainda sem material"
  },
  PanelText_UI_Collection_Panel_Equip_Text_C_None_Content = {
    Text = "Sem coleções relacionadas"
  },
  PanelText_UI_Collection_Panel_Equip_Text_C_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Collection_Panel_Event_Text_C_Placeholder_Content = {
    Text = "Procurar substantivo"
  },
  PanelText_UI_Collection_Panel_History_Text_C_Label_Content = {Text = "Crônica"},
  PanelText_UI_Collection_Panel_History_Text_C_Mail_Content = {
    Text = "Progresso de coleta"
  },
  PanelText_UI_Collection_Panel_History_Text_C_Title_Content = {Text = "Biblioteca"},
  PanelText_UI_Collection_Panel_LoginPV_Text_Title_Content = {
    Text = "Alterar Fundo de Login"
  },
  PanelText_UI_Collection_Panel_LoginPV_Text_Title_En_Content = {
    Text = "Alterar Fundo de Login"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Creation_Content = {Text = "Criação"},
  PanelText_UI_Collection_Panel_Main_Text_C_Event_Content = {Text = "Evento"},
  PanelText_UI_Collection_Panel_Main_Text_C_Image_Content = {Text = "Imagem"},
  PanelText_UI_Collection_Panel_Main_Text_C_Music_Content = {Text = "fonógrafo"},
  PanelText_UI_Collection_Panel_Main_Text_C_Progress_Content = {
    Text = "Progresso de coleta"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_Role_Content = {Text = "Personagem"},
  PanelText_UI_Collection_Panel_Main_Text_C_Title_Content = {Text = "Biblioteca"},
  PanelText_UI_Collection_Panel_Main_Text_C_Trinket_Content = {Text = "Mystik"},
  PanelText_UI_Collection_Panel_Main_Text_C_Weapon_Content = {
    Text = "Roda do destino"
  },
  PanelText_UI_Collection_Panel_Main_Text_C_World_Content = {
    Text = "Mundo Hongji"
  },
  PanelText_UI_Collection_Panel_Music_Play_Text_C_Mail_Content = {
    Text = "Progresso de coleta"
  },
  PanelText_UI_Collection_Panel_Music_Play_Text_C_Title_Content = {Text = "Biblioteca"},
  PanelText_UI_Collection_Panel_Organize_Text_C_Mail_Content = {
    Text = "Progresso de coleta"
  },
  PanelText_UI_Collection_Panel_Organize_Text_Title_Content = {Text = "Biblioteca"},
  PanelText_UI_Collection_Panel_Relic_Text_C_Mail_Content = {
    Text = "Progresso de coleta"
  },
  PanelText_UI_Collection_Panel_Relic_Text_C_Title_Content = {Text = "História"},
  PanelText_UI_Collection_Panel_Relic_Text_Title_Content = {Text = "Biblioteca"},
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Cancel_Content = {Text = "Cancelar"},
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Display_Content = {
    Text = "Mostrar despertos"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_DownLoadCG_Content = {
    Text = "Baixar Imagem Original"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_HideAwaker_Content = {
    Text = "Definir esta imagem como fundo do dormitório fará com que a ilustração do visitante desapareça"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Hide_Content = {
    Text = "Ocultar Despertado"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_High_Content = {
    Text = "Retroceder Fundo"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Normal_Content = {
    Text = "Definir como fundo do dormitório"
  },
  PanelText_UI_Collection_Panel_SetMainBg_Text_C_Save_Content = {Text = "Salvar"},
  PanelText_UI_Collection_Panel_Unlock_Text_C_Cost_Content = {Text = "Consumo"},
  PanelText_UI_Collection_Panel_World_Text_C_Chronicle_Content = {Text = "Crônica"},
  PanelText_UI_Collection_Panel_World_Text_C_Comprehensive_Content = {
    Text = "Livro Proibido de Hongji"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Label_Content = {
    Text = "Mundo Hongji"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Organize_Content = {
    Text = "Organização"
  },
  PanelText_UI_Collection_Panel_World_Text_C_Title_Content = {Text = "Biblioteca"},
  PanelText_UI_Collection_Panel_World_Text_Progress_Content = {
    Text = "Progresso de coleta"
  },
  PanelText_UI_Common_Awaker_Favor_Text_C_Sync_Content = {
    Text = "A taxa de afinidade do despertador aumentou"
  },
  PanelText_UI_Common_Btn_Receive_Small_Text_C_Name_Content = {Text = "Receber"},
  PanelText_UI_Common_Btn_Share_Text_C_Across_Content = {
    Text = "Primeira vez compartilhando"
  },
  PanelText_UI_Common_Btn_Share_Text_C_Share_Content = {
    Text = "Primeira vez compartilhando"
  },
  PanelText_UI_Common_Btn_Small_240x90_Text_Name_Content = {
    Text = "Ativar talento"
  },
  PanelText_UI_Common_Group_Coin_Text_C_Text_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Common_Item_Detail_Text_C_AavtarName_Content = {
    Text = "Avatar e Expressão"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Avatar_Info_Content = {
    Text = "Prévia de detalhes"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Close_Content = {Text = "Recolher"},
  PanelText_UI_Common_Item_Detail_Text_C_Equipped_Content = {Text = "Equipado"},
  PanelText_UI_Common_Item_Detail_Text_C_KeeperSkill_Title_Content = {
    Text = "Efeito da Chave:"
  },
  PanelText_UI_Common_Item_Detail_Text_C_Source_Content = {
    Text = "Obter origem"
  },
  PanelText_UI_Common_Item_Hint_Text_C_Recommend_Content = {Text = "Recomendar"},
  PanelText_UI_Common_Item_Tip_Bg_Text_C_Name_Content = {
    Text = "Ordenação"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Dispatch_Content = {
    Text = "Despachando"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Expired_Content = {Text = "Expirado"},
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_NoEquip_Content = {
    Text = "Não pode ser equipado"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_NotActive_Content = {Text = "Sem efeito"},
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_UpperLimit_Content = {
    Text = "Limite atingido"
  },
  PanelText_UI_Common_Item_WuPin_Type1_Text_C_Using_Content = {Text = "Em uso"},
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Full_Content = {
    Text = "Iluminar Completo"
  },
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Double_Content = {Text = "Dobro"},
  PanelText_UI_Common_Item_WuPin_Type2_Text_C_Tab_Nor_Content = {Text = "Extra"},
  PanelText_UI_Common_Melt_Disaster_Text_C_Suppress_Content = {Text = "D-tide"},
  PanelText_UI_Common_Popup_Card_List_Text_C_AbandonCard_Content = {
    Text = "Monte de descarte"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_DrawCard_Content = {
    Text = "Mazo de robo"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_Empty_Content = {
    Text = "Atualmente, o baralho de cartas está vazio"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_NoTask_Content = {
    Text = "Nenhum cartão disponível"
  },
  PanelText_UI_Common_Popup_Card_List_Text_C_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Common_Popup_Consume_Text_C_Cancel_Content = {Text = "Cancelar"},
  PanelText_UI_Common_Popup_Consume_Text_C_Confirm_Content = {Text = "Confirmar"},
  PanelText_UI_Common_Popup_Consume_Text_C_Title_Content = {
    Text = "Confirmação de Uso de Item"
  },
  PanelText_UI_Common_Popup_Tip_01_Text_C_Screening_Content = {
    Text = "Não lembrar mais hoje"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_C_Screening_Content = {
    Text = "Não lembrar mais hoje"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_C_ShopNeed_Content = {
    Text = "Quantidade de cupons atual"
  },
  PanelText_UI_Common_Popup_Tip_3_Text_Screening_Content = {
    Text = "Não lembrar mais hoje"
  },
  PanelText_UI_Common_Popup_Tip_4_Text_C_Info_Content = {
    Text = "<WhiteQuality:Clique no Espaço em Branco para Fechar>"
  },
  PanelText_UI_Common_Popup_Tip_5_Text_C_Info_Content = {
    Text = "Clique no espaço em branco para fechar"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_C_Tips_Content = {
    Text = "Após mudar o nome, não pode ser alterado por 72 horas"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_NameCancel_Content = {Text = "Cancelar"},
  PanelText_UI_Common_Popup_Tip_6_Text_NameConfirm_Content = {Text = "Confirmar"},
  PanelText_UI_Common_Popup_Tip_6_Text_Placeholder_Content = {
    Text = "Insira seu nome"
  },
  PanelText_UI_Common_Popup_Tip_6_Text_Title_Content = {Text = "Mudar nome"},
  PanelText_UI_Common_Popup_Tips_6_Text_null_Content = {
    Text = "(já danificado)"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Material_Content = {
    Text = "Materiais de Edificação"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Reward_Content = {
    Text = "Recompensa da Edificação"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_L_Text_C_Title_Content = {
    Text = "Pré-visualização de Edificação"
  },
  PanelText_UI_Common_Popup_Tips_Confirm_S_Text_C_Day_Content = {Text = "Dia"},
  PanelText_UI_Common_Popup_Tips_Confirm_S_Text_C_Month_Content = {Text = "Lua"},
  PanelText_UI_Common_Popup_Tips_Small_Text_C_Scroll_Tips_Content = {
    Text = "Deslize para cima e para baixo para ver mais recompensas"
  },
  PanelText_UI_Community_Acclaim_Tips_Text_C_Name_1_Content = {
    Text = "Ir para Avaliar"
  },
  PanelText_UI_Community_Steer_Tips_Text_Thanks_Name_Content = {
    Text = "Agradecimento especial"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_LetterTitle_Content = {
    Text = "Para os prezados voluntários locais:"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Name_Content = {
    Text = "Nativo voluntário"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Signature_Content = {
    Text = "Conselho da Universidade de Missaga"
  },
  PanelText_UI_Community_ThanksLetter_Text_C_Sincerely_Content = {
    Text = "Agradeço profundamente"
  },
  PanelText_UI_Community_ThanksLetter_Text_Prefix_Content = {
    Text = "Com sua sensibilidade linguística e amor pelos jogos, você transforma o texto rígido da tradução automática em uma linguagem vibrante. Essa dedicação altruísta permite que os Guardiões do Segredo em todo o mundo desfrutem da autêntica experiência de \"Véspera do Esquecimento\".\n       A Universidade de Misag agradece sinceramente às seguintes contribuições excepcionais dos Guardiões do Segredo:"
  },
  PanelText_UI_Community_ThanksLetter_Text_Suffix_Content = {
    Text = "Que a Chave de Prata nos guie"
  },
  PanelText_UI_Community_ThanksLetter_Text_Title_Content = {
    Text = "Agradecimento especial"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Award_Content = {Text = "Arquivado"},
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Free_Unlock_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Copy_Item_StoryChapter_Text_C_Lock_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Copy_Story_View_Text_C_ReadTip_Content = {
    Text = "A ordem recomendada representa apenas a ordem de leitura sugerida, não uma ordem cronológica estrita."
  },
  PanelText_UI_Course_Panel_Main_Text_C_NoTask_Content = {
    Text = "Sem tutoriais deste tipo no momento"
  },
  PanelText_UI_Course_Panel_Main_Text_C_Placeholder_Content = {
    Text = "Procurar tutorial"
  },
  PanelText_UI_Course_Panel_Text_Title_Content = {Text = "Tutorial"},
  PanelText_UI_Dbgcopy_Item_Select_Goods_Text_C_Sellout_Content = {Text = "Esgotado"},
  PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Achievement_Content = {
    Text = "Conquista da fase"
  },
  PanelText_UI_Dbgcopy_Item_Target_Title_Text_C_Star_Content = {
    Text = "Classificação por Estrelas"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Arousal_Sellout_Content = {Text = "Esgotado"},
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Curse_Content = {
    Text = "Entre Maldições"
  },
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Sell_Sellout_Content = {Text = "Esgotado"},
  PanelText_UI_Dbgcopy_Panel_Action_Text_C_Spend_Content = {Text = "Custo"},
  PanelText_UI_Dbgcopy_Panel_Main_New_Text_C_Count_Content = {Text = "D-tide"},
  PanelText_UI_Dbgcopy_Panel_RelicPreview_Text_Name_Content = {Text = "Voltar"},
  PanelText_UI_Dbgcopy_Panel_RelicStrength_Text_C_Title_Content = {
    Text = "Fortalecer a Criação"
  },
  PanelText_UI_Dbgcopy_Panel_Select_Arousal_Text_C_Name_Content = {Text = "Escolher"},
  PanelText_UI_Dbgcopy_Panel_Select_Extra_Text_C_Name_Content = {Text = "Desistir"},
  PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Display_Content = {
    Text = "Mostrar eventos"
  },
  PanelText_UI_Dbgcopy_Popup_Event_New_Text_C_Hide_Content = {
    Text = "Ocultar evento"
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Monster_Content = {
    Text = "Criações da fase"
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Tip_Content = {
    Text = "Por favor, guardião, esteja ciente de que diferentes capítulos de fase trazem características ambientais e criações iniciais diferentes."
  },
  PanelText_UI_Dbgcopy_Popup_LevelChapter_Text_C_Title_Content = {
    Text = "Descrição do efeito da fase do capítulo"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Confirm_Content = {Text = "Confirmar"},
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Replace_Content = {
    Text = "Substituir personagem"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_TeamAwaker_Content = {
    Text = "Personagens na equipe atual"
  },
  PanelText_UI_Dbgcopy_Popup_ReplaceAwaker_Text_C_Title_Content = {
    Text = "Selecionar troca de personagem"
  },
  PanelText_UI_Dbgcopy_Popup_Vibes_Text_C_Suppress_Content = {
    Text = "Reprodução"
  },
  PanelText_UI_Dbgcopy_Popup_Vibes_Text_C_Title_Content = {
    Text = "Descrição do efeito da maré negra do desastre"
  },
  PanelText_UI_Dbgcopy_Popup_ydbj_yty_01_Text_C_Dcks_Content = {
    Text = "Início da Investigação"
  },
  PanelText_UI_Dungeons_BattleTeaching_View_Text_BtnName_Content = {
    Text = "Começar Treinamento"
  },
  PanelText_UI_Dungeons_BattleTeaching_View_Text_C_Award_Content = {
    Text = "Recompensa da missão"
  },
  PanelText_UI_Dungeons_Item_Common_Element_Text_C_Award_Content = {
    Text = "Recompensa +100%"
  },
  PanelText_UI_Dungeons_Item_Common_Tier2_Text_C_Current_Content = {Text = "Concluído"},
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Extra_Content = {
    Text = "Extra - Concluído"
  },
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Name_Content = {Text = "Resetar"},
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Name_Extra_Content = {Text = "Resetar"},
  PanelText_UI_Dungeons_Item_Level_Content_Text_C_Undone_Content = {
    Text = "Desafio incompleto"
  },
  PanelText_UI_Dungeons_Item_RailWayRank_Text_C_Null_Content = {
    Text = "暂无阵容"
  },
  PanelText_UI_Dungeons_Material_View_Text_C_ActivityAchievement_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_All_Content = {Text = "Tudo"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Awaker_Content = {Text = "Batalha"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_BattleStatistics_Content = {
    Text = "Estatísticas da Batalha"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Damage_Content = {Text = "Causa dano"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Heal_Content = {
    Text = "Causar tratamento"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_BattleStatistics_Content = {Text = "Sem dados"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Null_RoundStatistics_Content = {Text = "Sem dados"},
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_RoundStatistics_Content = {
    Text = "Estatísticas da Rodada"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Shield_Content = {
    Text = "Causar Escudo"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Time_BattleStatistics_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Dungeons_Panel_CopyStatistics_Text_C_Time_RoundStatistics_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Experience_Content = {
    Text = "Nível de Mergulho Profundo"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Highest_Content = {
    Text = "Pontuação máxima da semana"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Rank_Content = {
    Text = "Tabela de Ranking"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Record_Content = {
    Text = "Resultado desta semana"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Store_Content = {
    Text = "Loja de Trocas"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_C_Title_Content = {
    Text = "Título de Nível de Investigação"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Diving_Record_Content = {
    Text = "Registro da Submersão"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_New_Text_Main_Title_Content = {
    Text = "Mergulho fantasmal"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Highest_Content = {
    Text = "Pontuação máxima da semana"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record2_Content = {
    Text = "Resultado desta semana"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Record_Content = {
    Text = "Resultado da semana"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Reward2_Content = {
    Text = "Registro da Submersão"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Store_Content = {
    Text = "Loja de Trocas"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_Title_Content = {
    Text = "Título de Nível de Investigação"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_C_illustrate_Content = {
    Text = "Regras do Jogo"
  },
  PanelText_UI_Dungeons_Panel_Daily_Challenge_Text_list_Content = {
    Text = "Ranking da temporada"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Appraise_Content = {
    Text = "Estatísticas de Pontuação"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Finish_Content = {
    Text = "Investigação Bem-sucedida"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_High_Content = {
    Text = "Novo recorde!"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Remind_Content = {
    Text = "Aumente a capacidade de despertar antes de desafiar inimigos fortes!"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Score_Content = {
    Text = "Pontuação total"
  },
  PanelText_UI_Dungeons_Panel_Daily_Out_Text_C_Synthesis_Content = {
    Text = "(=soma ×3)"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Award_Content = {
    Text = "Recompensa de conclusão"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Highest_Content = {
    Text = "Recorde máximo"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Record_Content = {
    Text = "Resultado de hoje"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Reward_Content = {
    Text = "Prova semanal"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Score_Content = {
    Text = "Pontuação semanal acumulada"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Store_Content = {
    Text = "Loja de Trocas"
  },
  PanelText_UI_Dungeons_Panel_Daily_Text_C_Title_Content = {
    Text = "Título de Investigação"
  },
  PanelText_UI_Dungeons_Panel_Material_Text_Award_Content = {
    Text = "Recompensa da missão"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Appraise_Content = {
    Text = "Estatísticas de Pontuação"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_BattleData_Content = {
    Text = "Dados de Investigação"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Finish_Content = {
    Text = "Investigação Concluída"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_High_Content = {
    Text = "Novo recorde!"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Huodewuzi_Content = {
    Text = "Recompensa de liquidação"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Integral_Content = {
    Text = "Avaliação de Investigação"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Limit_Content = {
    Text = "※Limite de itens atingido"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Score_Content = {
    Text = "Pontuação total"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Statistics_Content = {
    Text = "Estatísticas de batalha"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Sync_Content = {
    Text = "A taxa de afinidade do despertador aumentou"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_Synthesis_Content = {
    Text = "(=soma ×3)"
  },
  PanelText_UI_Dungeons_Panel_Out_Text_C_TeamInfo_Content = {
    Text = "Informações da equipe"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval1_Content = {Text = "intervalo"},
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Interval2_Content = {
    Text = "Intervalo de rotação"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_1_Content = {
    Text = "Domínio do Caos"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_2_Content = {
    Text = "Torre da Lua de Sangue"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_3_Content = {
    Text = "Abismo do Mar Sombrio"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Name_4_Content = {
    Text = "Viagem Hiperdimensional"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_1_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_2_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_3_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_NotUnlocked_4_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_Tips_Content = {
    Text = "Troca Sem Luz"
  },
  PanelText_UI_Dungeons_Panel_Realms_Text_C_illustrate_Content = {
    Text = "Regras do Jogo"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Card2_Content = {
    Text = "(contendo oração)"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Card_Content = {
    Text = "Estatísticas da carta"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_KeyToken_Content = {
    Text = "Ordem de chave"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_NoTask_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Null_Content = {
    Text = "Sem Criações disponíveis"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_PlayerLevel_Content = {
    Text = "Nível do Guardião"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Relic_Content = {Text = "Criação"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Reset_Content = {Text = "Resetar"},
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamData_Content = {
    Text = "Dados da equipe"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_TeamProperty_Content = {
    Text = "Atributos da equipe"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Team_Content = {
    Text = "Equipe de Investigação"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_C_Uid_Content = {
    Text = "ID do Guardião:"
  },
  PanelText_UI_Dungeons_Panel_SurveyData_Text_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Dungeons_Panel_Trinket_Text_C_Award_Content = {
    Text = "Recompensa da missão"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Activity_Awaker_Content = {
    Text = "Capítulo Esquecido · Limitado"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Award_Content = {
    Text = "Recompensa concluída"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Emoji_Content = {Text = "expressão"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Introduce_Content = {
    Text = "Introdução de capacidade"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Name_1_Content = {Text = "Receber"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Name_Content = {
    Text = "Iniciar teste"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Normal_Awaker_Content = {Text = "permanente"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Star_Awaker_Content = {
    Text = "Capítulo das Estrelas · Limitado"
  },
  PanelText_UI_Dungeons_Panel_Try_Text_C_Undone_Content = {Text = "Incompleto"},
  PanelText_UI_Dungeons_Panel_Try_Text_C_Wake_Content = {
    Text = "Ir para Despertar"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_ActivityAchievement_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_AwardText_Content = {
    Text = "Recompensas semanais disponíveis"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Optimized_Text_C_Award_Content = {
    Text = "Recompensa da missão"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_AwardText_Content = {
    Text = "Recompensas semanais disponíveis"
  },
  PanelText_UI_Dungeons_Panel_WeekBOSS_Text_C_Award_Content = {
    Text = "Recompensa da missão"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Info_Content = {
    Text = "Informações do Guardião"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_More_Content = {
    Text = "Ver detalhes"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_NoTask_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Rank_Content = {
    Text = "Classificação"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Replay_Content = {
    Text = "Gravação de registro"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_C_Value_Content = {
    Text = "Pontos de Treinamento"
  },
  PanelText_UI_Dungeons_Popup_AbyssRank_Text_Title_Content = {
    Text = "Tabela de Ranking"
  },
  PanelText_UI_Dungeons_Popup_Award_Optimized_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Dungeons_Popup_Award_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Awaker_Content = {Text = "Batalha"},
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Damage_Content = {Text = "Causa dano"},
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Heal_Content = {
    Text = "Causar tratamento"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Shield_Content = {
    Text = "Causar Escudo"
  },
  PanelText_UI_Dungeons_Popup_BattleStatistics_Text_C_Title_Content = {
    Text = "Estatísticas de combate"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_FilterAwaker_Content = {
    Text = "Filtrar Corpo Desperto"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_No_Records_Content = {
    Text = "Sem registros de investigação"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_Refresh_Content = {Text = "Trocar"},
  PanelText_UI_Dungeons_Popup_Clearance_Text_C_Title_Content = {
    Text = "Registro de conclusão"
  },
  PanelText_UI_Dungeons_Popup_Clearance_Text_Fliter_Type_Content = {
    Text = "Total de turnos"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Award_Content = {
    Text = "Ranking alto"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Big_Content = {
    Text = "Intervalo de Classificação"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Current_Content = {
    Text = "Recompensa atual"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Empty_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_FilterAwaker_Content = {
    Text = "Filtrar Corpo Desperto"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Grade_Content = {
    Text = "Título de Investigação"
  },
  ["PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Haven't_Content"] = {
    Text = "Sem recompensas"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Highest_Content = {
    Text = "Recorde máximo"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_1_Content = {
    Text = "Informações do Guardião"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_2_Content = {
    Text = "Título de Investigação"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_3_Content = {
    Text = "Recorde máximo"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_4_Content = {
    Text = "Classificação"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_5_Content = {Text = "Formação"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Information_6_Content = {Text = "Lembre-se"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Me_Content = {
    Text = "Minha classificação"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_NoTask_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Prompt_Content = {
    Text = "E-mails de recompensa serão enviados toda segunda-feira às 9:00 com base nos títulos de investigação"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward1_Content = {
    Text = "Recompensa de Ranking"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_RankAward2_Content = {
    Text = "Recompensa de Ranking"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Ranking_Content = {
    Text = "Classificação"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Reward_Content = {Text = "Recompensa"},
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season1_Content = {
    Text = "Ranking da temporada"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Season2_Content = {
    Text = "Ranking da temporada"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Small_Content = {
    Text = "Menor ou igual a"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking1_Content = {
    Text = "Ranking da temporada"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_SurveyRanking2_Content = {
    Text = "Ranking da temporada"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_Title_Content = {
    Text = "Ranking de Investigação"
  },
  PanelText_UI_Dungeons_Popup_List_Tip_Text_C_illustrate_Content = {
    Text = "Recompensa de Ranking"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Big_Content = {
    Text = "Intervalo de Classificação"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_DivingTitle_Content = {
    Text = "Título de Investigação"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Exp_Content = {
    Text = "Progresso Máximo"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Grade_Content = {
    Text = "Título de Investigação"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Info_Content = {
    Text = "Informações do Guardião"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_NoTask_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Nor_Content = {
    Text = "Recompensa de Ranking"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_RankAward_Sel_Content = {
    Text = "Recompensa de Ranking"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Content = {
    Text = "Classificação"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Nor_Content = {
    Text = "Ranking da temporada"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Rank_Sel_Content = {
    Text = "Ranking da temporada"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Replay_Content = {Text = "Lembre-se"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Reward_Content = {Text = "Recompensa"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Round_Content = {
    Text = "Número de turnos"
  },
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Team_Content = {Text = "Formação"},
  PanelText_UI_Dungeons_Popup_RailWayRank_Text_C_Title_Content = {
    Text = "Lista de Convidados"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Big_Content = {Text = "Maior que"},
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Reward_Content = {Text = "Recompensa"},
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Small_Content = {
    Text = "Menor ou igual a"
  },
  PanelText_UI_Dungeons_Popup_Reward_Tip_Text_C_Title_Content = {
    Text = "Recompensa de Ranking"
  },
  PanelText_UI_Dungeons_Popup_Rules_Tip_Text_C_Title_Content = {
    Text = "Descrição do Jogo"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Award_Content = {
    Text = "Prévia da Recompensa"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_2_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Dungeons_RogueStage_View_Text_C_Title_Content = {
    Text = "Pombo de carne de torre"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Award_Content = {
    Text = "Prévia da Recompensa"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Challenge_Content = {
    Text = "Modo padrão"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Daily_Content = {
    Text = "Desafio diário"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_Name_Content = {
    Text = "Pombo de carne de torre"
  },
  PanelText_UI_Dungeons_Rogue_View_Text_C_NoTask_Content = {Text = "Aguardando"},
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_EnergyCost_Content = {
    Text = "Poder de cálculo"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Extra_Content = {
    Text = "Bônus Extra"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_KeeperSkill_Content = {
    Text = "Energia da Chave de Prata"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_Manual_Content = {
    Text = "Combate manual"
  },
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_UltiEnergy_Content = {Text = "Fúria"},
  PanelText_UI_Dungeons_Tip_AwakerFavor_Text_C_UseCard_Content = {
    Text = "Jogar Carta"
  },
  PanelText_UI_Dungeons_Trinket_View_Text_C_ActivityAchievement_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Lost_Content = {
    Text = "Não alcançado"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title2_Content = {
    Text = "Pontuação acumulada até"
  },
  PanelText_UI_Dungeous_Item_Popup_Award2_Text_C_Title_Content = {
    Text = "Estrelas desta fase"
  },
  PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Lost_Content = {
    Text = "Não alcançado"
  },
  PanelText_UI_Dungeous_Item_Popup_Award_Text_C_Title_Content = {
    Text = "Estrelas de pontuação desta fase"
  },
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Null_Content = {
    Text = "暂无阵容"
  },
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Dungeous_Item_Ranking_Text_C_Underway_Content = {
    Text = "Comunicação de dados de batalha"
  },
  PanelText_UI_Dungeous_Item_Reward_Text_C_Present_Content = {Text = "Atual"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Additional_Content = {
    Text = "Recompensa extra de hoje +50% ilimitada"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardNum_Content = {
    Text = "Recompensas em dobro hoje"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_AwardText_Content = {
    Text = "Recompensas semanais disponíveis"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Award_Content = {
    Text = "Recompensa da missão"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Boundaries_Tips_Content = {
    Text = "Recomendar domínio"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Creation_Content = {
    Text = "Criações da fase"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Name_Content = {Text = "Reproduzir"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Recommend_Content = {
    Text = "Recomendar domínio"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_1_Content = {Text = "Caos"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_2_Content = {Text = "Ultra"},
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_3_Content = {
    Text = "Carne e sangue"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_School_4_Content = {
    Text = "Mar Profundo"
  },
  PanelText_UI_Dungeous_Panel_BossSel1_Text_C_Special_Content = {
    Text = "Criação inicial"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_AwardText_Content = {
    Text = "Recompensas semanais disponíveis"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Award_Content = {
    Text = "Detalhes do inimigo"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Boundaries_Tips_Content = {
    Text = "Recomendar domínio"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Reward_Content = {
    Text = "Recompensa de conclusão"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_C_Special_Content = {
    Text = "Criação inicial"
  },
  PanelText_UI_Dungeous_Panel_BossSel_Text_Title_Content = {
    Text = "Existência Transcendental"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Award_Content = {
    Text = "Pré-visualização do chefe"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Boundaries_Tips_Content = {
    Text = "Recomendar domínio"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Creation_Content = {
    Text = "Criações da fase"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Difficulty_Content = {
    Text = "Profundidade de submersão"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Reward_Content = {
    Text = "Prévia da Recompensa"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Score_Content = {
    Text = "Pontuação máxima da semana"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_C_Special_Content = {
    Text = "Criação inicial"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_RewardShow_Content = {
    Text = "Prévia da Recompensa"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Optimized_Text_StrongAwakers_Content = {
    Text = "Reforço do Corpo Desperto"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Creation_Content = {
    Text = "Criações da fase"
  },
  PanelText_UI_Dungeous_Panel_Difficulty_Text_C_Suppress_Content = {Text = "D-tide"},
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Creation_Content = {
    Text = "Criações da fase"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Remuneration_Content = {
    Text = "Recompensa de personagem"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Dungeous_Panel_Lake_City_Text_C_Special_Content = {
    Text = "Criação inicial"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Hint_Content = {
    Text = "*No Zona de Corrosão, Despertados e Rodas do Destino em batalha não podem lutar em outras zonas"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Rank_Content = {
    Text = "Tabela de Ranking"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Title_Content = {
    Text = "Zona Proibida de Catástrofe de Fusão"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Train_Content = {
    Text = "Valor de treino atual"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Optimized_Text_C_Weekly_Content = {
    Text = "Recompensa de Treinamento Especial"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Hint_Content = {
    Text = "*Após a conclusão, os Despertados, Rodas do Destino e Chaves usados não podem ser usados em outras zonas de Corrosão"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Title_Content = {
    Text = "Zona Proibida de Catástrofe de Fusão"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Train_Content = {
    Text = "Valor de treino atual"
  },
  PanelText_UI_Dungeous_Panel_Melt_Erosion_Text_C_Weekly_Content = {
    Text = "Recompensa de Treinamento Especial"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Creation_Content = {
    Text = "Criações da fase"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Extra_Content = {
    Text = "Extra - Concluir Formação"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Integral_Content = {
    Text = "Pontos de conclusão"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_LineUp_Content = {
    Text = "Concluir Formação"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Monster_Content = {
    Text = "Prévia do Monstro"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Content = {Text = "Resetar"},
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Name_Extra_Content = {Text = "Resetar"},
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_None_Content = {
    Text = "Sem formação"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Replay_Content = {Text = "Registrar"},
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_C_Special_Content = {
    Text = "Criação inicial"
  },
  PanelText_UI_Dungeous_Panel_Molten_Optimized_Text_Extra_None_Content = {
    Text = "Desafio não concluído"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Creation_Content = {
    Text = "Criações da fase"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Integral_Content = {
    Text = "Concluir Valor de Treinamento"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_LineUp_Content = {
    Text = "Complete a Escala"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Monster_Content = {
    Text = "Prévia do Monstro"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Name_Content = {Text = "Resetar"},
  PanelText_UI_Dungeous_Panel_Molten_Text_C_None_Content = {
    Text = "Desafio não concluído"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Special_Content = {
    Text = "Criação inicial"
  },
  PanelText_UI_Dungeous_Panel_Molten_Text_C_Suppress_Content = {Text = "D-tide"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Challenge_Content = {Text = "Desafio"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Choose_Content = {
    Text = "Dificuldade de escolha"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Experience_Content = {
    Text = "Especificações do Quarto Elegante"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Hard_Content = {
    Text = "Dificuldade"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Madness_Content = {Text = "Loucura"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Normal_Content = {Text = "Comum"},
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Rank_Content = {
    Text = "Lista de Hóspedes"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Record_Content = {
    Text = "Registro ao longo do caminho"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Resonance_Content = {
    Text = "A assistência do \"N\" pequeno"
  },
  PanelText_UI_Dungeous_Panel_RailWay_Text_C_Title_Content = {
    Text = "Trem de Alegria Acelerado"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Award2_Content = {
    Text = "Lei do domínio"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Award_Content = {
    Text = "Detalhes do inimigo"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Boundaries_Tips_Content = {
    Text = "Recomendar domínio"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Cost_Tips_Content = {
    Text = "Requisitos da equipe:"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Creation_Content = {
    Text = "Criações da fase"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Replay_Content = {Text = "Lembre-se"},
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Reward_Content = {
    Text = "Prévia da Recompensa"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Special_Content = {
    Text = "Criação inicial"
  },
  PanelText_UI_Dungeous_Panel_Realms_New_Text_C_Tishi_Content = {
    Text = "Prévia da Recompensa"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Award2_Content = {
    Text = "Leis do Domínio"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Award_Content = {
    Text = "Detalhes do inimigo"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Boundaries_Tips_Content = {
    Text = "Recomendar domínio"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Cost_Tips_Content = {
    Text = "Requisitos da equipe"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Creation_Content = {
    Text = "Criações da fase"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Reward_Content = {
    Text = "Prévia da Recompensa"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Special_Content = {
    Text = "Criação inicial"
  },
  PanelText_UI_Dungeous_Panel_Realms_Text_C_Tishi_Content = {
    Text = "Progresso de Classificação por Estrelas"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Additional_Content = {
    Text = "Recompensa extra de hoje +50% ilimitada"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_AwardNum_Content = {
    Text = "Recompensas em dobro hoje"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Award_Content = {
    Text = "Recompensa da missão"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Boundaries_Tips_Content = {
    Text = "Recomendar domínio"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Cw_Content = {Text = "Ultra"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Hd_Content = {Text = "Caos"},
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Recommend_Content = {
    Text = "Recomendar domínio"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Sh_Content = {
    Text = "Mar Profundo"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Special_Content = {
    Text = "Criação inicial"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_C_Xr_Content = {
    Text = "Carne e sangue"
  },
  PanelText_UI_Dungeous_Panel_SecEntrance_Text_Name_Content = {Text = "Reproduzir"},
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_1_Content = {
    Text = "Ainda não selecionou a roda do destino"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_2_Content = {
    Text = "Clique à esquerda para selecionar"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Hint_Content = {
    Text = "*Cada Despertar só pode equipar uma Roda do Destino SSR"
  },
  PanelText_UI_Dungeous_Popup_Awaker_List_Text_C_Title_Content = {
    Text = "Escolha roda do destino"
  },
  PanelText_UI_Dungeous_Popup_FailTip_Text_C_Title_Content = {
    Text = "Como ficar mais forte"
  },
  PanelText_UI_Dungeous_Popup_Prop_Award_Text_C_Title_Content = {
    Text = "Prévia de Recompensas por Estrelas"
  },
  PanelText_UI_Dungeous_Popup_Prop_Award_Text_C_Title_En_Content = {Text = "Pode obter"},
  PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Title_Content = {
    Text = "Estatísticas de Pontuação"
  },
  PanelText_UI_Dungeous_Popup_Score_Tip_Text_C_Total_Content = {
    Text = "Pontuação total atual"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Coin_Content = {
    Text = "Moeda insuficiente"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Explain_Content = {Text = "Regras"},
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_RewardPreview_Content = {
    Text = "Prévia da Recompensa"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Swept_Content = {
    Text = "Número de recriações"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Text_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_C_Tips_Content = {
    Text = "Avaliação de Investigação Três Estrelas Desbloqueada"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip2_Text_Title_Content = {
    Text = "Confirmação de recriação"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Deplete_Content = {
    Text = "Custo de recriação"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Swept_Content = {
    Text = "Número de recriações"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Team_Content = {
    Text = "Equipe de Investigação"
  },
  PanelText_UI_Dungeous_Popup_Swept_Tip_Text_C_Title_Content = {
    Text = "Confirmação de recriação"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Difficulty_Content = {Text = "Resetar"},
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_NoTask_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Prohibit_Content = {
    Text = "Chave desativada nesta fase"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Skill_Content = {
    Text = "Habilidades do Guardião"
  },
  PanelText_UI_Dungeous_Popup_Team_Tip_Text_C_Title_Content = {
    Text = "Equipe de desafio"
  },
  PanelText_UI_Dungeous_Popup_Tips_New_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity2_Content = {
    Text = "Recompensa de Primeira Conclusão"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Activity_Content = {
    Text = "Recompensa de Primeira Conclusão"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Game2_Content = {
    Text = "Recompensa acumulada"
  },
  PanelText_UI_Dungeous_Popup_Tips_Text_C_Game_Content = {
    Text = "Recompensa acumulada"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Again_Content = {
    Text = "Resetar desafio"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Boundaries_Tips_Content = {
    Text = "Recomendar domínio"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Creation_Content = {
    Text = "Criações da fase"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Cw_Content = {Text = "Ultra"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Hd_Content = {Text = "Caos"},
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Monster_Content = {
    Text = "Prévia do Monstro"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Sh_Content = {
    Text = "Mar Profundo"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Title_Content = {
    Text = "Criação inicial"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_Xr_Content = {
    Text = "Carne e sangue"
  },
  PanelText_UI_Dungeous_Weekly_Difficulty_Text_C_illustrate_Content = {
    Text = "Regras do Jogo"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Again_Content = {
    Text = "Resetar desafio"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Tips_Content = {
    Text = "Detalhes da Recompensa"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_Title_Content = {
    Text = "Prévia da Recompensa"
  },
  PanelText_UI_Dungeous_Weekly_Main_Text_C_illustrate_Content = {
    Text = "Regras do Jogo"
  },
  PanelText_UI_Dungeous_illustrate_Tip_Text_C_Title_Content = {
    Text = "Reino sem luz"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Finish_Content = {
    Text = "Evento encerrado, obtenção parada"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Full_Content = {
    Text = "Limite de armazenamento atingido"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_Reward_Content = {
    Text = "Obtenha inventário"
  },
  PanelText_UI_Event_Activity_Castor_Text_C_SpeedTitle_Content = {
    Text = "Velocidade de armazenamento:"
  },
  PanelText_UI_Event_Activity_Castor_Text_None_Content = {
    Text = "Nenhum material disponível"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Finish_Content = {
    Text = "Evento encerrado"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Full_Content = {
    Text = "Os suprimentos atingiram o limite máximo"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_None_Content = {
    Text = "Nenhum material de doação disponível"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_Reward_Content = {
    Text = "Inventário"
  },
  PanelText_UI_Event_Activity_DonationBox_Text_C_SpeedTitle_Content = {
    Text = "Velocidade de obtenção:"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Finish_Content = {
    Text = "Evento encerrado"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Full_Content = {
    Text = "Armazenamento no limite"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_Reward_Content = {
    Text = "Armazenar informações"
  },
  PanelText_UI_Event_Activity_Horla_Text_C_SpeedTitle_Content = {
    Text = "Velocidade de armazenamento"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Finish_Content = {
    Text = "Evento encerrado, obtenção parada"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Full_Content = {
    Text = "Limite de armazenamento atingido"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_Reward_Content = {
    Text = "Obtenha inventário"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_C_SpeedTitle_Content = {
    Text = "Velocidade de armazenamento:"
  },
  PanelText_UI_Event_Activity_KathiguRa_Text_None_Content = {
    Text = "Nenhum material disponível"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Label_Content = {
    Text = "Loja da Sra. Grey"
  },
  PanelText_UI_Event_Activity_Main_Text_C_Mail_Content = {Text = "Regras"},
  PanelText_UI_Event_Activity_Main_Text_C_Title_Content = {
    Text = "Local de venda beneficente da igreja"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Finish_Content = {
    Text = "Evento encerrado, obtenção parada"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Full_Content = {
    Text = "Limite de armazenamento atingido"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_Reward_Content = {
    Text = "Obtenha inventário"
  },
  PanelText_UI_Event_Activity_Miriam_Text_C_SpeedTitle_Content = {
    Text = "Velocidade de obtenção"
  },
  PanelText_UI_Event_Activity_Miriam_Text_None_Content = {
    Text = "Nenhum material disponível"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Finish_Content = {
    Text = "Evento encerrado, obtenção parada"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Full_Content = {
    Text = "Limite de armazenamento atingido"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_Reward_Content = {
    Text = "Obtenha inventário"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_C_SpeedTitle_Content = {
    Text = "Velocidade de armazenamento:"
  },
  PanelText_UI_Event_Activity_OriMurphy_Text_None_Content = {
    Text = "Nenhum material disponível"
  },
  PanelText_UI_Event_Activity_Pollux_Text_None_Content = {
    Text = "Nenhum material disponível"
  },
  PanelText_UI_Event_Activity_RewardList_Text_C_Reward_Content = {
    Text = "Lista de venda"
  },
  PanelText_UI_Event_Activity_RewardPool_Text_C_Name_Content = {Text = "Resetar"},
  PanelText_UI_Event_Activity_RewardPool_Text_Name_Content = {Text = "Troca Tudo"},
  PanelText_UI_Event_Activity_RewardResult_Text_C_Close_Content = {
    Text = "Clique no espaço em branco para voltar"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_CoreReward_Content = {
    Text = "Semente Especial"
  },
  PanelText_UI_Event_Activity_RewardResult_Text_C_Result_Content = {
    Text = "Resultado da troca"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_C_Desc_Content = {
    Text = "Mestre também vai ajudar a Karen a limpar hoje? Que ótimo! Este é um pequeno presente da Karen, por favor, aceite com certeza!"
  },
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_1_Content = {Text = "Recebido"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_2_Content = {Text = "Recebido"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_3_Content = {Text = "Recebido"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_4_Content = {Text = "Recebido"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_5_Content = {Text = "Recebido"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_6_Content = {Text = "Recebido"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Receive_7_Content = {Text = "Recebido"},
  PanelText_UI_Event_Activity_SevenDaySign_Text_Title_Content = {
    Text = "O presente de agradecimento de Karen"
  },
  PanelText_UI_Event_Activity_SummerSign_Text_C_Desc_Content = {
    Text = "Sol, areia, ondas e inúmeros rostos sorridentes – que tal um jogo de voleibol cheio de energia no sonho de verão!"
  },
  PanelText_UI_Event_Activity_SummerSign_Text_Title_Content = {
    Text = "Festa de Verão sem Fim"
  },
  PanelText_UI_Event_Activity_SummonBenefits_Text_C_Summon_Content = {
    Text = "Convocação Grátis"
  },
  PanelText_UI_Event_Activity_Thing_Item_Text_C_Sold_Out_Content = {Text = "Esgotado"},
  PanelText_UI_Event_Activity_Thing_Item_Text_C_Special_Tips_Content = {Text = "Especial"},
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Finish_Content = {
    Text = "Evento encerrado, armazenamento parado"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Full_Content = {
    Text = "Limite de material de armazenamento atingido"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Reward_Content = {
    Text = "Material de Armazenamento"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_SpeedTitle_Content = {
    Text = "Velocidade de armazenamento:"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_C_Title_Content = {
    Text = "Armazenamento de Borda"
  },
  PanelText_UI_Event_Activity_TwentyFour_Text_Name_Content = {Text = "Receber"},
  PanelText_UI_Event_Activity_TwentyFour_Text_None_Content = {
    Text = "Nenhum material disponível"
  },
  PanelText_UI_Event_Activity_XiaomaoGift_Text_C_Receive_Content = {
    Text = "Restante de tentativas de despertar:"
  },
  PanelText_UI_Event_Challenge_Item_Text_C_Finish_Content = {
    Text = "Última passagem"
  },
  PanelText_UI_Event_Item_Return_Text_C_Close_Content = {
    Text = "Clique na tela para fechar"
  },
  PanelText_UI_Event_Item_Return_Text_C_Finish_Content = {Text = "Recebido"},
  PanelText_UI_Event_Item_SignDay_Text_C_CanReceive_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Event_Item_SignDay_Text_C_Got_Content = {Text = "Recebido"},
  PanelText_UI_Event_Item_SignDay_Text_C_Nor_Content = {Text = "A receber"},
  PanelText_UI_Event_Item_WeaponOptional_Text_C_Got_Content = {Text = "Possuído"},
  PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Event_Panel_Activity_Fundraising_Text_C_Title_Content = {
    Text = "Área da igreja"
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Introduction_Content = {
    Text = "Shh... Respire fundo, relaxe seus tentáculos. Agora você vai mergulhar na mente de \"24\" e explorar memórias ocultas"
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Event_Panel_Activity_TwentyFour_Text_C_Title_Content = {
    Text = "Código de memória"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Awaker_Content = {
    Text = "Teste do Corpo Desperto"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_FristCreation_Content = {
    Text = "Criação inicial"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Leader_Content = {
    Text = "Pré-visualização do chefe"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Record_Content = {Text = "Desafio"},
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_StarTitle_Content = {
    Text = "Objetivo de estrelas"
  },
  PanelText_UI_Event_Panel_ChallengeDifficulty_Text_C_Title_Content = {
    Text = "Misterio do roteiro"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Creation_Content = {
    Text = "Criações da fase"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Double_Content = {
    Text = "Desafio em dobro"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_FristCreation_Content = {
    Text = "Criação inicial"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Leader_Content = {
    Text = "Pré-visualização do chefe<WordSize20:>"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_MeltErosion_Content = {Text = "D-tide"},
  PanelText_UI_Event_Panel_Challenge_Text_C_Monster_Content = {
    Text = "Prévia do Monstro"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Record_Content = {Text = "Desafio"},
  PanelText_UI_Event_Panel_Challenge_Text_C_RemainNum_Content = {
    Text = "Quantidade de clones restantes"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_Replay_Content = {Text = "Lembre-se"},
  PanelText_UI_Event_Panel_Challenge_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_RewardTitle_Content = {
    Text = "Recompensa da missão"
  },
  PanelText_UI_Event_Panel_Challenge_Text_C_SweepName_Content = {Text = "Limpeza"},
  PanelText_UI_Event_Panel_Challenge_Text_C_Title_Content = {
    Text = "Misterio do roteiro"
  },
  PanelText_UI_Event_Panel_Challenge_Text_Career_Content = {
    Text = "Requer reino 1"
  },
  PanelText_UI_Event_RewardGroup_Text_C_Reset_Content = {
    Text = "Tentativas de reset restantes:"
  },
  PanelText_UI_Event_Reward_Item_Text_C_Not_Content = {Text = "Incompleto"},
  PanelText_UI_Event_Reward_Item_Text_C_Receive_Content = {Text = "Receber"},
  PanelText_UI_Event_Task_Item_Text_C_Not_Content = {
    Text = "Não alcançado"
  },
  PanelText_UI_Event_Task_Item_Text_C_Receive_Content = {Text = "Receber"},
  PanelText_UI_Event_WeaponOptional_Text_C_Receive_Content = {
    Text = "Restante de tentativas de despertar:"
  },
  PanelText_UI_Events_2ndAnnivWB_StageGroup_Text_C_Introduction_Content = {
    Text = "Venha, com loucura, massacre e dor como notas, cante este requiem que brilha entre as estrelas. \n A suprema existência do caos, não deve despertar, nem agora, nem no futuro."
  },
  PanelText_UI_Events_2ndAnnivWB_StageGroup_Text_C_Title_Content = {
    Text = "Requiem das Estrelas"
  },
  PanelText_UI_Events_Activity_StageGroup_Text_C_Introduction_Content = {
    Text = "A promessa do Deus está próxima.\nApós milênios de espera, o fim alegre está prestes a chegar, a terra prometida surgirá do mar.\nA divindade ressurgirá do peito da Mãe Divina, e quando os sete dias terminarem, um novo mundo chegará."
  },
  PanelText_UI_Events_Activity_StageGroup_Text_C_Title_Content = {
    Text = "Sete dias de criação"
  },
  PanelText_UI_Events_Item_Castor_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Castor_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_Clementine_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Clementine_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_Daffodil_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Daffodil_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_Doresain_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Doresain_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_GiftBag_Text_C_Free_Content = {Text = "Grátis"},
  PanelText_UI_Events_Item_GiftBag_Text_C_High_Content = {Text = "Grátis"},
  PanelText_UI_Events_Item_GiftBag_Text_C_Noraml_Content = {Text = "Receber"},
  PanelText_UI_Events_Item_GiftBag_Text_C_Soldout_Content = {Text = "Recebido"},
  PanelText_UI_Events_Item_Hamline_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Hamline_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_KathiguRa_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_KathiguRa_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_Lake_City_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Lake_City_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_Miriam_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Miriam_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_Murphy_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Murphy_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Killed_Content = {Text = "Eliminado!"},
  PanelText_UI_Events_Item_OceanBoss_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_OceanBoss_Text_C_Progress_Content = {
    Text = "Mas desafiar"
  },
  PanelText_UI_Events_Item_Optional_Text_C_Full_Content = {
    Text = "Iluminar Completo"
  },
  PanelText_UI_Events_Item_Optional_Text_C_Have_Content = {Text = "Possuído"},
  PanelText_UI_Events_Item_OriDoll_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_OriDoll_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_OriMurphy_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_OriMurphy_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_Pickman_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Pickman_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_Pollux_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Pollux_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_PreOrderGift_Text_C_Lock_Content = {
    Text = "Receba após a compra"
  },
  PanelText_UI_Events_Item_RAIDProgressGroup_Text_C_Kill_Content = {
    Text = "Capturas Totais"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Career_Content = {
    Text = "Requisitos da equipe"
  },
  PanelText_UI_Events_Item_RAID_Text_C_Finish_Content = {Text = "Concluído"},
  PanelText_UI_Events_Item_RAID_Text_C_Kill_Content = {Text = "Capturado"},
  PanelText_UI_Events_Item_RAID_Text_CareerLimit_Content = {Text = "Ilimitado"},
  PanelText_UI_Events_Item_RAID_Text_Lock_Content = {
    Text = "Ainda Não Disponível"
  },
  PanelText_UI_Events_Item_Rome_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Rome_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_Ryker_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Ryker_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_SignDiamond_Text_C_Receive_Content = {Text = "Recebido"},
  PanelText_UI_Events_Item_Sorel_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Sorel_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_StElmosFire_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_StElmosFire_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_Stage_Text_C_Undone_Content = {Text = "Incompleto"},
  PanelText_UI_Events_Item_Summer1_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Summer1_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_Summer2_Text_C_NormalTip_Content = {
    Text = "Dificuldade normal pendente de conclusão"
  },
  PanelText_UI_Events_Item_SurveyDiary_Text_Name_Content = {Text = "Receber"},
  PanelText_UI_Events_Item_Tab_Text_C_Return_Content = {
    Text = "Evento de retorno"
  },
  PanelText_UI_Events_Item_Tawil_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Tawil_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_C_Career_Content = {
    Text = "Requisitos da equipe"
  },
  PanelText_UI_Events_Item_TeamSchool_Text_C_Finish_Content = {Text = "Concluído"},
  PanelText_UI_Events_Item_TeamSchool_Text_CareerLimit_Content = {Text = "Ilimitado"},
  PanelText_UI_Events_Item_Tulu_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Tulu_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_TwentyFour_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_TwentyFour_Text_C_LockTips_Content = {
    Text = "Desbloqueia após concluir a fase prévia do Registro de Tarefa"
  },
  PanelText_UI_Events_Item_Wanda_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_Wanda_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Killed_Content = {Text = "Eliminado!"},
  PanelText_UI_Events_Item_WorldBoss_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Item_WorldBoss_Text_C_Progress_Content = {
    Text = "Quantidade de clones restantes"
  },
  PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Introduction_Content = {
    Text = "Abandone o corpo, abandone a razão, neste mundo de pura vontade, sinta a Sua presença.\nEle é o seu único. Ele é também o seu tudo."
  },
  PanelText_UI_Events_OceanBoss_StageGroup_Text_C_Title_Content = {
    Text = "Maré Inquieta"
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Introduction_Content = {
    Text = "Abra a boca, morda com força.\nEngolir e ser engolido, essa é a regra da batalha, esse é o destino das feras"
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_OriHelot_StageGroup_Text_C_Title_Content = {
    Text = "Ambição da Besta"
  },
  PanelText_UI_Events_OriHelot_Text_C_Fall_Content = {
    Text = "Prévia de Queda"
  },
  PanelText_UI_Events_OriHelot_Text_C_LockTips_Content = {
    Text = "Dica de desbloqueio de fase"
  },
  PanelText_UI_Events_Panel_2ndAnnivWorldBoss_Text_C_Challenge_Content = {
    Text = "Requiem das Estrelas"
  },
  PanelText_UI_Events_Panel_2ndAnnivWorldBoss_Text_C_ProgressTitle_Content = {
    Text = "Progresso do Kill Mundial"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_Ordinary_Content = {
    Text = "Jornada comum"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_PassportUp_Content = {
    Text = "Passe de Batalha Avançado"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_Senior_Content = {
    Text = "Arquivo Avançado"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_C_illustrate_Content = {
    Text = "Descrição do evento"
  },
  PanelText_UI_Events_Panel_ActivityPassport_Text_PayTip_Content = {
    Text = "O preço exibido atualmente é o preço padrão da moeda, apenas para referência. Na hora do pagamento, prevalecerá a moeda e o preço reais."
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Introduction_Content = {
    Text = "As luzes se acendem. Os aplausos cessam. A plateia aguarda em expectativa.\nÉ hora de subir ao palco, minhas queridas crianças. Sigam em frente—atuem, rasguem suas próprias almas e vendam seus segredos mais profundos. Tomem suas feridas mais devastadoras e transformem-nas em doces para o deleite da plateia. Banhem-se avidamente naquele único feixe de luz aceso apenas para vocês, até que a cortina caia para sepultar tanto vocês quanto sua plateia.\n\nEste é o palco ao qual vocês foram destinados—subam! Não tenham medo; não há necessidade de pânico de palco."
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Arachne_StageGroup_Text_C_Title_Content = {
    Text = "Palco da Marionete"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Challenge_Content = {
    Text = "Palco da Marionete"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Record_Content = {
    Text = "Registro da força-tarefa"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Shop_Content = {
    Text = "Loja de Presentes do Teatro"
  },
  PanelText_UI_Events_Panel_Arachne_Text_C_Topic_Content = {
    Text = "Tecelão Aprisionado"
  },
  PanelText_UI_Events_Panel_Attendance_Text_C_GiftTitle_Content = {
    Text = "Concluir missão para receber o voucher de troca de Roupa Fantasma"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_1_Content = {
    Text = "Mergulho Fantasmal"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_2_Content = {
    Text = "Fase de Duelo"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Award_Content = {
    Text = "Mergulho Fantasmal"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Over_Content = {
    Text = "A experiência do guardião de hoje foi obtida:"
  },
  PanelText_UI_Events_Panel_Award_Text_C_Title_Content = {
    Text = "A experiência do guardião de hoje foi obtida:"
  },
  PanelText_UI_Events_Panel_Back_To_School_Text_C_Not_Unlocked_Content = {
    Text = "Ainda não desbloqueado"
  },
  PanelText_UI_Events_Panel_Back_To_School_Text_C_Shop_Content = {
    Text = "Loja de volta às aulas"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Challenge_Content = {
    Text = "Caminho do Santuário"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Fill_Up_Content = {
    Text = "(Distância para o limite de armazenamento:"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Finish_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Fundraising_Content = {
    Text = "Bondade dos cidadãos"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Not_unlocked_Content = {
    Text = "<Gray:Não desbloqueado>"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Pv_Content = {Text = "Lembrança"},
  PanelText_UI_Events_Panel_Banquet_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Record_Content = {
    Text = "A cor do sangue"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Resonance_Content = {
    Text = "Ressonância: Bifurcação da Alma"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Shop_Content = {
    Text = "Local de venda beneficente da igreja"
  },
  PanelText_UI_Events_Panel_Banquet_Text_C_Topic_Content = {
    Text = "Pastor das Almas: Reedição"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Award_Content = {
    Text = "Recompensa por tempo limitado"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Limit_Content = {
    Text = "Recompensa de Investigação"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Over_Content = {
    Text = "Todas as recompensas foram recebidas"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Pass_Content = {
    Text = "Recompensa de conclusão"
  },
  PanelText_UI_Events_Panel_Branch_Text_C_Title_Content = {
    Text = "Prévia da Recompensa"
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Introduction_Content = {
    Text = "♪~~♫~~♪~~♫~~♪~~♫~~\nAbaixo da montanha nevada, todo guia a recorda, e toda criança ainda a canta. Ela é a vontade da majestosa montanha feita carne, ela é a misericordiosa deusa Umapati. Seu poder divino está espalhado pelo mundo mortal; seus tesouros não podem ser encontrados. Estão perto o suficiente para tocar; não deixam rastro algum. \nAbra mão de algo. Segure algo. Aqueles cujo coração for falso diante da verdadeira forma da deusa serão enterrados na montanha nevada para sempre, junto com a montanha que morreu."
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Caraboo_StageGroup_Text_C_Title_Content = {
    Text = "Tesouros de Umapati"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Challenge_Content = {
    Text = "Tesouros de Umapati"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Record_Content = {
    Text = "Operação especial"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Shop_Content = {
    Text = "Rituais da Fada"
  },
  PanelText_UI_Events_Panel_Caraboo_Text_C_Topic_Content = {
    Text = "Lua Nova e Neve Profunda"
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Introduction_Content = {
    Text = "A vida de um pássaro está destinada a ser uma vida de liberdade. Você deve ter visto o momento em que ele rompeu a casca, recuperando a liberdade da vida das garras da morte. Você deve ter visto quando ele aprendeu a voar, recuperando a liberdade de sobreviver sozinho, longe do conforto do ninho. Agora, se a chave da liberdade for jogada no abismo da morte, ele certamente não hesitará em saltar, escolhendo enfrentar a tempestade da morte entre a vida estreita e a liberdade infinita."
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Castor_StageGroup_Text_C_Title_Content = {
    Text = "Voo pelo céu azul"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Challenge_Content = {
    Text = "Voo pelo céu azul"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Castor_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Record_Content = {
    Text = "Visão de Sonhos Estranhos"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Shop_Content = {
    Text = "Desejo de conhecimento"
  },
  PanelText_UI_Events_Panel_Castor_Text_C_Topic_Content = {
    Text = "Prisioneiro Espelho"
  },
  PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Introduction_Content = {
    Text = "Desde então, ela não derramou mais uma única lágrima. \nVagando sozinha, pairando em um mundo cheio de estranhos. \nUm grande plano está prestes a começar, sendo este o seu último adeus. \nEla é a psicóloga mais bem-sucedida; este é o seu tratamento mais bem-sucedido."
  },
  PanelText_UI_Events_Panel_Clementine_StageGroup_Text_C_Title_Content = {
    Text = "Cura do Medo"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Challenge_Content = {
    Text = "Cura do Medo"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Clementine_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Record_Content = {
    Text = "Navegação na consciência"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Resonance_Content = {
    Text = "Ressonância: Nenhum"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Shop_Content = {
    Text = "Sala de Tratamento Neurológico"
  },
  PanelText_UI_Events_Panel_Clementine_Text_C_Topic_Content = {
    Text = "Enterrado na memória"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Empty_Content = {
    Text = "Todas as recompensas obtidas"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Lottery_Content = {
    Text = "Compre 1 carta"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Rate_Content = {
    Text = "Explicação de probabilidade"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Tip_Content = {
    Text = "<color=#e3c96e>Roupa Fantasma da Chave de Prata</color> tem chance de ser obtida a partir da <color=#e3c96e>5ª</color> extração"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_C_Topic_Content = {
    Text = "Pastor das Almas"
  },
  PanelText_UI_Events_Panel_ClotherLottery_Text_Free_Content = {Text = "Grátis"},
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Introduction_Content = {
    Text = "Nesta pequena cidade costeira, existe uma movimentada rua comercial. O comércio marítimo trouxe uma infinidade de produtos modernos, e com o suficiente de Leonian Florin, você sempre encontrará mercadorias satisfatórias. \n Exceto por uma pequena loja no canto da rua, que é cheia de antiguidades mágicas, onde a proprietária, usando um chapéu de aba larga, lhe mostrará um sorriso suave através da fumaça que sai de seu cachimbo. \n \"Bem-vindo à loja de alívio, aqui você pode satisfazer todas as suas necessidades, desde que pague um preço justo...\" \n \"Claro, claro, os preços são justos e não há engano.\""
  },
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Daffodil_StageGroup_Text_C_Title_Content = {
    Text = "Loja da Bruxa"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Challenge_Content = {
    Text = "Loja da Bruxa"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Daffodil_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Record_Content = {
    Text = "Registro da força-tarefa"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Shop_Content = {
    Text = "Tesouro da Bruxa"
  },
  PanelText_UI_Events_Panel_Daffodil_Text_C_Topic_Content = {
    Text = "Sombra da cidade chuvosa"
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Introduction_Content = {
    Text = "A corda já está no zênite, e a décima terceira badalada já soou.\nEsta noite, a faca de jantar do poeta cantará para nós.\nEsta noite, a garganta da mãe nos abraçará."
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Doresain_StageGroup_Text_C_Title_Content = {
    Text = "Banquete de Devorar Almas"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Challenge_Content = {
    Text = "Banquete de Devorar Almas"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Doresain_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Record_Content = {
    Text = "Registro de despacho"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Shop_Content = {
    Text = "Restaurante do Palácio Real"
  },
  PanelText_UI_Events_Panel_Doresain_Text_C_Topic_Content = {
    Text = "Estética necrótica"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_Ordinary_Content = {
    Text = "Jornada comum"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_PassportUp_Content = {
    Text = "Passe de Batalha Avançado"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_Senior_Content = {
    Text = "Arquivo Avançado"
  },
  PanelText_UI_Events_Panel_GamePassport_Text_C_illustrate_Content = {
    Text = "Descrição do evento"
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Introduction_Content = {
    Text = "O som de estrondo ressoa na ponta de sua vara.\nImerso em um longo sonho, até o capítulo final da destruição"
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Hameln_StageGroup_Text_C_Title_Content = {
    Text = "Som tonante"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Challenge_Content = {
    Text = "Som tonante"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Hamline_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Record_Content = {
    Text = "Registro da força-tarefa"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Resonance_Content = {
    Text = "Ressonância: Nenhum"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Shop_Content = {
    Text = "Palácio do Sono"
  },
  PanelText_UI_Events_Panel_Hamline_Text_C_Topic_Content = {
    Text = "Sinfonia Imaterial"
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Introduction_Content = {
    Text = "Uma rosa solitária está presa na estufa decadente"
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Horla_StageGroup_Text_C_Title_Content = {
    Text = "Jardim de memórias"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Challenge_Content = {
    Text = "Jardim de memórias"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Horla_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Record_Content = {
    Text = "Registro da força-tarefa"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Resonance_Content = {
    Text = "Ressonância: Elegia do Jardim"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Shop_Content = {
    Text = "Casa de Flores da Colette"
  },
  PanelText_UI_Events_Panel_Horla_Text_C_Topic_Content = {
    Text = "Antes que a primavera murche"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Reward_Content = {
    Text = "Subsídio de Limpeza"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Sign_Content = {
    Text = "O presente de agradecimento de Karen"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Task_Content = {
    Text = "Progresso de limpeza"
  },
  PanelText_UI_Events_Panel_Karen_Text_C_Topic_Content = {
    Text = "Viagem Maravilhosa de Limpeza"
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Introduction_Content = {
    Text = "Ela se ergue novamente sobre a Terra, e a vingança que consome tudo chega como prometido. \n\n É uma caça incessante, é o fogo ardente do Senhor da Chama Explosiva. \n\n Ela percorrerá cada canto, caçando todos aqueles que firmaram um pacto com a morte. \n\n Fuja, fuja, fuja para as trevas mais profundas, fuja para onde você acha que não será encontrado. \n\n Embora isso seja inútil, pois Ele acabará pisando em cada mundo. \n\n Ele caçará tudo até que tudo se consuma em cinzas."
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_KathiguRa_StageGroup_Text_C_Title_Content = {
    Text = "Caça à Cinza"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Challenge_Content = {
    Text = "Caça à Cinza"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Fill_Up_Content = {
    Text = "(Distância para o limite de armazenamento:"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Record_Content = {
    Text = "Navegação na consciência"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Shop_Content = {
    Text = "Base Secreta"
  },
  PanelText_UI_Events_Panel_KathiguRa_Text_C_Topic_Content = {
    Text = "Mil Raios Brilhantes Descem"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Describe_Content = {
    Text = "Você vê não só a escolha da alma, mas também sua vida errante"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_Title_Content = {
    Text = "Caminho do Santuário"
  },
  PanelText_UI_Events_Panel_Lake_City_Text_C_illustrate_Content = {
    Text = "Regras do Jogo"
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Introduction_Content = {
    Text = "As tarefas atribuídas por Boneca nunca são simples. \nMesmo com várias lembranças para todos se \"divertirem\", como os guardiões poderiam não ficar assustados ao levar um grupo de despertadores pela primeira vez? \nMas, não se esqueça de \"divertir-se\""
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Lily_StageGroup_Text_C_Title_Content = {
    Text = "Misterio do roteiro"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Challenge_Content = {
    Text = "Misterio do roteiro"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Pv_Content = {
    Text = "Reproduzir imagem"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Record_Content = {
    Text = "Registro da força-tarefa"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Resonance_Content = {
    Text = "Ressonância: Código do Diretor"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Shop_Content = {
    Text = "Loja de roteiros mágicos"
  },
  PanelText_UI_Events_Panel_Lily_Text_C_Topic_Content = {
    Text = "A magia da história · Recriação"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Introduction_Content = {
    Text = "Força, poder, riqueza, liberdade... Nas terras do Leviatã, Ele lhe concederá tudo o que você anseia.\nDesde que, claro, você seja o último a sobreviver."
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_StageGroup_Text_C_Title_Content = {
    Text = "Ganância e Sede de Sangue"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Challenge_Content = {
    Text = "Ganância e Sede de Sangue"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Record_Content = {
    Text = "Navegação na consciência"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Shop_Content = {
    Text = "Altar da Arena"
  },
  PanelText_UI_Events_Panel_LotanCetarchon_Text_C_Topic_Content = {
    Text = "O Jogo do Leviatã"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Challenge_Content = {
    Text = "Misterio do roteiro"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Desc_Content = {
    Text = "As tarefas atribuídas por Boneca nunca são simples. \nMesmo com várias lembranças para todos se \"divertirem\", como os guardiões poderiam não ficar assustados ao levar um grupo de despertadores pela primeira vez? \nMas, não se esqueça de \"divertir-se\""
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Own_Content = {
    Text = "Atualmente possui"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Record_Content = {
    Text = "Registro da força-tarefa"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Resonance_Content = {
    Text = "Ressonância: Código do Diretor"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Shop_Content = {
    Text = "Loja de roteiros mágicos"
  },
  PanelText_UI_Events_Panel_MagicStory_Text_C_Topic_Content = {
    Text = "A Magia da História"
  },
  PanelText_UI_Events_Panel_Main_Text_C_PermanentActivity_Content = {Text = "Fliperama"},
  PanelText_UI_Events_Panel_Main_Text_C_PermanentRule_Content = {Text = "Fliperama"},
  PanelText_UI_Events_Panel_Main_Text_C_Pv_Content = {
    Text = "Reproduzir imagem"
  },
  PanelText_UI_Events_Panel_Main_Text_C_SevenDays_Content = {
    Text = "Check-in de sete dias"
  },
  PanelText_UI_Events_Panel_Main_Text_C_illustrate_Content = {
    Text = "Descrição do evento"
  },
  PanelText_UI_Events_Panel_Main_Text_Title_Content = {Text = "Evento"},
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Introduction_Content = {
    Text = "Siga este caminho difícil e sagrado. No final do caminho, a última porta se abrirá para você"
  },
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Miriam_StageGroup_Text_C_Title_Content = {
    Text = "Nascimento do Reino Divino"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Challenge_Content = {
    Text = "Nascimento do Reino Divino"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Miriam_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Record_Content = {
    Text = "Visão de Sonhos Estranhos"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Resonance_Content = {
    Text = "Ressonância: Ritual do Abismo"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Shop_Content = {
    Text = "Resposta do Abismo"
  },
  PanelText_UI_Events_Panel_Miriam_Text_C_Topic_Content = {
    Text = "Cerimônia do Abismo"
  },
  PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Introduction_Content = {
    Text = "Céu~ensolarado~mar~calmo~\nMosk~amigo~Pequena bola de carvão~zarpar!\nTempestade, não tenha medo, relâmpago, não tenha medo, Mosk, amigo, Pequena bola de carvão~\nPela liberdade, vamos·partir"
  },
  PanelText_UI_Events_Panel_Mosk_StageGroup_Text_C_Title_Content = {
    Text = "Mosk e o mar"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Challenge_Content = {
    Text = "Mosk e o mar"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Record_Content = {Text = "Vício"},
  PanelText_UI_Events_Panel_Mosk_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Shop_Content = {
    Text = "Tesouro de Mosk"
  },
  PanelText_UI_Events_Panel_Mosk_Text_C_Topic_Content = {
    Text = "Chamado de Musk"
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Introduction_Content = {
    Text = "Um dia, você de repente percebe que se tornou diferente. \n Ninguém nota isso porque você ainda exibe os mesmos comportamentos e tem a mesma aparência bonita. \n Mas você sabe muito bem que o coração vermelho brilhante de antes agora está coberto por uma máscara feita de névoa. \n \"Se eu conseguir continuar fingindo, ainda sou eu mesmo de antes?\" \n Felizmente, essa pergunta não permanece em sua mente por mais de um segundo; afinal, antes que a máscara seja retirada, ninguém conhece seus verdadeiros pensamentos. \n \"Então, vamos partir~\""
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Mouchette_StageGroup_Text_C_Title_Content = {Text = "Eu perdido"},
  PanelText_UI_Events_Panel_Mouchette_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Challenge_Content = {Text = "Eu perdido"},
  PanelText_UI_Events_Panel_Mouchette_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Record_Content = {
    Text = "Conexão multidimensional"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Shop_Content = {
    Text = "Casa de Mouchette"
  },
  PanelText_UI_Events_Panel_Mouchette_Text_C_Topic_Content = {
    Text = "Ritual da Névoa"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Introduction_Content = {
    Text = "De Sua @1escuridão@2, o grande @3vem ao mundo"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Murphy_StageGroup_Text_C_Title_Content = {
    Text = "Útero Escuro"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Challenge_Content = {
    Text = "Útero Escuro"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Homology_Content = {
    Text = "Durante o evento, a afinidade obtida por todos os meios será dobrada!"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Pv_Content = {
    Text = "Reproduzir imagem"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Record_Content = {
    Text = "Hino à Rosa"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Shop_Content = {
    Text = "Eclosão do embrião sagrado"
  },
  PanelText_UI_Events_Panel_Murphy_Text_C_Topic_Content = {
    Text = "Alinhamento das Estrelas · Reproduzido"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_Challenge_Content = {
    Text = "Maré Inquieta"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_GiftTitle_Content = {
    Text = "Concluir missão para receber o voucher de troca de Roupa Fantasma"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_ProgressTitle_Content = {
    Text = "Progresso da Maré Anômala nas Eliminações"
  },
  PanelText_UI_Events_Panel_OceanBoss_Text_C_Topic_Content = {
    Text = "O Reino Divino emerge"
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Introduction_Content = {
    Text = "Ela olhou para a grande porta no fim do mundo e, sem hesitar, deu um passo à frente. \n Clique, ela girou a maçaneta e olhou ansiosamente para trás da porta. \n No entanto, havia nada atrás da porta, e ela pisou em falso, caindo no nada. \n Ela já deveria saber que, quando o presente chega de forma tão direta, sempre há um preço elevado a pagar."
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_OriDoll_StageGroup_Text_C_Title_Content = {
    Text = "Porta do Nada"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Challenge_Content = {
    Text = "Porta do Nada"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_OriDoll_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Record_Content = {
    Text = "Navegação na consciência"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Resonance_Content = {
    Text = "Ressonância: Nenhum"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Shop_Content = {
    Text = "Ensino do Mestre"
  },
  PanelText_UI_Events_Panel_OriDoll_Text_C_Topic_Content = {
    Text = "Um meio passo de distância"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Challenge_Content = {
    Text = "Ambição da Besta"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_OriHelot_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Record_Content = {
    Text = "Registro da força-tarefa"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Shop_Content = {
    Text = "Boca Gigante da Montanha"
  },
  PanelText_UI_Events_Panel_OriHelot_Text_C_Topic_Content = {
    Text = "Quando as montanhas nevadas derretem · Recriação"
  },
  PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Introduction_Content = {
    Text = "O que Deus prometeu já está próximo. \n Após milênios de espera, a conclusão alegre está prestes a chegar, a terra prometida emergirá do mar. \n A divindade ressurgirá do seio da Mãe Divina, e quando os sete dias terminarem, um novo mundo chegará."
  },
  PanelText_UI_Events_Panel_OriMurphy_StageGroup_Text_C_Title_Content = {
    Text = "Sete dias de criação"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Challenge_Content = {
    Text = "Sete dias de criação"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Record_Content = {
    Text = "Registro da força-tarefa"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Shop_Content = {
    Text = "Quarto da Mãe Divina"
  },
  PanelText_UI_Events_Panel_OriMurphy_Text_C_Topic_Content = {
    Text = "Cerimônia de sacrifício do Nascimento Divino"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_ChallengeTip_Content = {
    Text = "Evento de colaboração por tempo limitado"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Challenge_Content = {
    Text = "Fase de Duelo"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Record_Content = {
    Text = "Turno inverso"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Shop_Content = {
    Text = "Nome da Loja"
  },
  PanelText_UI_Events_Panel_PVPReRound_Text_C_Topic_Content = {
    Text = "Sombra da cidade chuvosa"
  },
  PanelText_UI_Events_Panel_PermanentActivity_Text_C_Reward_Content = {
    Text = "Recompensas Restantes"
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Introduction_Content = {
    Text = "Entre a razão e o crash, um rolo de engano se desenrola gradualmente.\nA ilusão que você despreza pinta cores deslumbrantes,\na perda de controle que você teme forma a lealdade.\nAqui, a loucura é o instinto da arte, a origem do mundo,\na única verdade que nunca mente."
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Pickman_StageGroup_Text_C_Title_Content = {
    Text = "Texto temporário"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Challenge_Content = {
    Text = "Texto temporário"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Record_Content = {
    Text = "Navegação na consciência"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Shop_Content = {
    Text = "Ateliê do Pikman"
  },
  PanelText_UI_Events_Panel_Pickman_Text_C_Topic_Content = {
    Text = "Texto temporário"
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Introduction_Content = {
    Text = "Aqueles ódios e amores, ternura e feridas, o que já tivemos e o que perdemos, já estão tão entrelaçados que não podemos desfazê-los. \n Deixe que nosso sangue e ossos se misturem, pois eles se reunirão em um só lugar, formando nosso destino indissolúvel."
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Pollux_StageGroup_Text_C_Title_Content = {
    Text = "Sangue amargo fundido"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Challenge_Content = {
    Text = "Sangue amargo fundido"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Pollux_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Record_Content = {
    Text = "Além do Horizonte - Parte 2"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Shop_Content = {
    Text = "Cerimônia de Bênção"
  },
  PanelText_UI_Events_Panel_Pollux_Text_C_Topic_Content = {
    Text = "Noite Eterna do Dia"
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Introduction_Content = {
    Text = "Quando a sinistra luz branca atravessa novamente as janelas da Casa, ele já lhe enviou um convite.\nAcolher, engolir, envolver, aglomerar... \nResponda ao Chamar das profundezas do oceano, junte-se a esta caçada incessante, seu passado, seu eu, tudo isso já não tem importância."
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Pontos_StageGroup_Text_C_Title_Content = {
    Text = "A Grande Caçada da Casa"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Challenge_Content = {
    Text = "A Grande Caçada da Casa"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Record_Content = {
    Text = "Navegação na consciência"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Shop_Content = {
    Text = "Terrenos de Caça"
  },
  PanelText_UI_Events_Panel_Pontos_Text_C_Topic_Content = {
    Text = "Ebwynnos Evermore"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Challenge_Content = {
    Text = "Corrida de Prata do gato"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Rank_Content = {
    Text = "Rankings de Captura"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Reward_Content = {
    Text = "Registro de Captura do Gato Preto"
  },
  PanelText_UI_Events_Panel_RAID_Text_C_Topic_Content = {
    Text = "Miau Obrigado!"
  },
  PanelText_UI_Events_Panel_RailWay_StageGroup_Text_C_Title_Content = {
    Text = "Partida do trem"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Challenge_Content = {
    Text = "Partida do trem"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Rank_Content = {
    Text = "Lista de Convidados VIP"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Record_Content = {
    Text = "Registro da força-tarefa"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Resonance_Content = {
    Text = "A assistência do \"N\" pequeno"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Reward_Content = {
    Text = "Marca de trilho longo"
  },
  PanelText_UI_Events_Panel_RailWay_Text_C_Topic_Content = {
    Text = "Trem de Alegria Acelerado"
  },
  PanelText_UI_Events_Panel_Reward_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Events_Panel_Reward_Text_Title_Content = {
    Text = "Recompensa da missão"
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Introduction_Content = {
    Text = "Somos carnívoros, somos descendentes de lobos. Aqueles pedaços deliciosos e ensanguentados de carne acabarão em nossas barrigas."
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Rome_StageGroup_Text_C_Title_Content = {
    Text = "Caça Divina"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Challenge_Content = {
    Text = "Caça Divina"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Rome_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Record_Content = {
    Text = "Visão de Sonhos Estranhos"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Shop_Content = {
    Text = "Oferecer tributo"
  },
  PanelText_UI_Events_Panel_Rome_Text_C_Topic_Content = {
    Text = "Roma! Evento Especial"
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Introduction_Content = {
    Text = "Sim, agora detetives comuns não estão mais na moda.\nSe você não pode voar ou não tem um assistente cientista, reconsidere sua carreira"
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Ryker_StageGroup_Text_C_Title_Content = {
    Text = "Lenda da noite lunar"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Challenge_Content = {
    Text = "Lenda da noite lunar"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Homology_Content = {
    Text = "Durante o evento, a afinidade obtida por todos os meios será dobrada!"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Pv_Content = {
    Text = "Reproduzir imagem"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Record_Content = {Text = "Boa caça!"},
  PanelText_UI_Events_Panel_Ryker_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Shop_Content = {
    Text = "Clube da Sorte"
  },
  PanelText_UI_Events_Panel_Ryker_Text_C_Topic_Content = {
    Text = "Manual do Detetive·Recuperação"
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Introduction_Content = {
    Text = "Ciência? Sem importância. Ética? Sem importância. Moralidade? Sem importância. \nVida, morte, esperança, desespero... no final, em um caderno no porão, a mesma prova está escrita por duas mãos diferentes. \nElas dizem: <Italic:\"Veja—o amor é o único e eterno tema.\">"
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Saya_StageGroup_Text_C_Title_Content = {
    Text = "Notas da câmara escura"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Challenge_Content = {
    Text = "Notas da câmara escura"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Record_Content = {
    Text = "Sementes esquecidas de amor"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Shop_Content = {
    Text = "Jardim de Dentes-de-Leão"
  },
  PanelText_UI_Events_Panel_Saya_Text_C_Topic_Content = {
    Text = "renascimento de cabeça para baixo"
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Introduction_Content = {
    Text = "Anos depois, um biógrafo bateu à sua porta ao entardecer.\nNaquele dia, conversaram muito, desde ágatas até a mansão das rosas murchas...\nAgora, o escritor compilou essas palavras fragmentadas em um livro, dedicado a todos vocês"
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Sorel_StageGroup_Text_C_Title_Content = {
    Text = "Memórias de Rosas"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Challenge_Content = {
    Text = "Memórias de Rosas"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Homology_Content = {
    Text = "Durante o evento, a afinidade obtida por todos os meios será dobrada!"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Pv_Content = {
    Text = "Reproduzir imagem"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Record_Content = {
    Text = "Hino à Rosa"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Shop_Content = {
    Text = "Celebração Dourada e Vermelha"
  },
  PanelText_UI_Events_Panel_Sorel_Text_C_Topic_Content = {
    Text = "Com o livro da rosa"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Limit_Content = {
    Text = "Recompensa de Investigação"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Over_Content = {
    Text = "Todas as condições de recompensa foram cumpridas"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Pass_Content = {
    Text = "Recompensa de conclusão"
  },
  PanelText_UI_Events_Panel_Spur_Text_C_Title_Content = {
    Text = "Pode ser reivindicado após concluir o teste do Despertar"
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Introduction_Content = {
    Text = "O sextante antigo determina o ângulo das estrelas, mapas marinhos antigos definem as rotas esperadas, e a bússola desgastada decide a direção a seguir…\nMesmo nas profundezas geladas do Mar Negro, ainda há exploradores que, com cobre e ferro comuns, guiam todos pelo caminho.\nQue todos os guias não caiam na confusão."
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_StElmosFire_StageGroup_Text_C_Title_Content = {
    Text = "Perdido nas Profundezas"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Challenge_Content = {
    Text = "Perdido nas Profundezas"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Record_Content = {
    Text = "Última navegação"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Shop_Content = {
    Text = "Tesouros da Tripulação"
  },
  PanelText_UI_Events_Panel_StElmosFire_Text_C_Topic_Content = {
    Text = "Na tempestade, balançando"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Introduction_Content = {
    Text = "Primeiro a amizade, depois o jogo? Só brincadeira! \nSuem sob o céu abrasador e corram em direção ao campeonato!"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Summer1_StageGroup_Text_C_Title_Content = {
    Text = "Voleibol de Praia"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Challenge_Content = {
    Text = "Voleibol de Praia"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Summer1_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Record_Content = {
    Text = "Visão de Sonhos Estranhos"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Shop_Content = {
    Text = "Pousada na Praia"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Sign_Content = {
    Text = "Festa de Verão sem Fim"
  },
  PanelText_UI_Events_Panel_Summer1_Text_C_Topic_Content = {
    Text = "Evento Especial de Verão - Parte 1"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Introduction_Content = {
    Text = "Sob o sol quente, tudo é tão acolhedor e feliz. \n Você olha para o céu azul como em um livro de contos de fadas e decide rasgar a tela com suas próprias mãos, rompendo o mundo falso."
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Progress_Content = {
    Text = "Progresso de Classificação por Estrelas"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Summer2_StageGroup_Text_C_Title_Content = {
    Text = "Nada de novo sob a luz do sol"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Challenge_Content = {
    Text = "Nada de novo sob a luz do sol"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Record_Content = {
    Text = "Visão de Sonhos Estranhos"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Shop_Content = {
    Text = "Prédio do Diretório Estudantil"
  },
  PanelText_UI_Events_Panel_Summer2_Text_C_Topic_Content = {
    Text = "Se tudo como de costume"
  },
  PanelText_UI_Events_Panel_SurveyDiary_Text_C_Return_Content = {
    Text = "Recompensa de retorno à escola"
  },
  PanelText_UI_Events_Panel_Task_Text_C_OneKeyName_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Events_Panel_Task_Text_Title_Content = {
    Text = "Progresso de limpeza"
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Introduction_Content = {
    Text = "Transcenda o Portal do Extremo, chegando ao domínio da Sabedoria Infinita.\nEnfrente o profano e compreenda o que é \"eu mesmo\".\nIsso é o \"Teste Final\" que Ele te concedeu"
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Tawil_StageGroup_Text_C_Title_Content = {
    Text = "Teste final"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Challenge_Content = {
    Text = "Teste final"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Record_Content = {
    Text = "Registro da força-tarefa"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Tawil_Text_C_Shop_Content = {Text = "Eco"},
  PanelText_UI_Events_Panel_Tawil_Text_C_Topic_Content = {
    Text = "Porta dos Mil Fenômenos"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Challenge_Content = {
    Text = "Dança dos Gatos"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Tip_Content = {
    Text = "Novos níveis com gatos escolares são desbloqueados diariamente, e ao completá-los você recebe recompensas valiosas!"
  },
  PanelText_UI_Events_Panel_TeamSchool_Text_C_Topic_Content = {
    Text = "Uma Nya Nya Rate"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Describe_Content = {
    Text = "O tempo flui em ciclos, e as flores murchas florescem novamente."
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_Title_Content = {
    Text = "Desejo caótico"
  },
  PanelText_UI_Events_Panel_Thais_StageGroup_Text_C_illustrate_Content = {
    Text = "Regras do Jogo"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Challenge_Content = {
    Text = "Desejo caótico"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Homology_Content = {
    Text = "Durante o evento, a afinidade obtida por todos os meios será dobrada!"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Pv_Content = {
    Text = "Reproduzir imagem"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_RecordTip_Content = {
    Text = "Desbloqueio com desconto por tempo limitado"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Record_Content = {
    Text = "Frenesi de reprodução"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Shop_Content = {
    Text = "Desejo Corrupto"
  },
  PanelText_UI_Events_Panel_Thais_Text_C_Topic_Content = {
    Text = "Ondas de Desejo"
  },
  PanelText_UI_Events_Panel_Try_Text_C_Fail_Content = {Text = "Incompleto"},
  PanelText_UI_Events_Panel_Try_Text_C_Summon_Content = {
    Text = "Ir para Despertar"
  },
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Introduction_Content = {
    Text = "Reze, ofereça, sacrifique, a profundidade humana é, para Ele, apenas um barulho irritante. \n Mas esta farsa, às vezes, também deixa marcas... nos olhos... ou no coração do rei divino.\n\n."
  },
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Tulu_StageGroup_Text_C_Title_Content = {
    Text = "Encaração do Mar Profundo"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Challenge_Content = {
    Text = "Encaração do Mar Profundo"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Tulu_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Record_Content = {
    Text = "Dia da Coroação"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Resonance_Content = {
    Text = "Ressonância: Devorador de Montanhas"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Shop_Content = {
    Text = "Abismo do mar da percepção"
  },
  PanelText_UI_Events_Panel_Tulu_Text_C_Topic_Content = {
    Text = "Revolução do Rei Divino"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Challenge_Content = {
    Text = "Código de memória"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Fill_Up_Content = {
    Text = "(Distância para o limite de armazenamento:"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Finish_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Not_unlocked_Content = {
    Text = "<Gray:Não desbloqueado>"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Pv_Content = {
    Text = "Reproduzir imagem"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Record_Content = {
    Text = "Fissão Tranquila"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Resonance_Content = {
    Text = "Ressonância: Síndrome de Separação"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Shop_Content = {
    Text = "Análise de personalidade"
  },
  PanelText_UI_Events_Panel_TwentyFour_Text_C_Topic_Content = {
    Text = "Cura múltipla: Réplica"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Describe_Content = {
    Text = "Isalrauh, a cidade no lago, supostamente é a terra natal de wanda.\nDesta vez você passará pela porta do sonho e chegará àquela antiga torre repleta de línguas de sino"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Resonance_Content = {
    Text = "Resonância"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_Title_Content = {
    Text = "Cidade no lago"
  },
  PanelText_UI_Events_Panel_Wanda_StageGroup_Text_C_illustrate_Content = {
    Text = "Regras do Jogo"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Can_Unlockable_Content = {
    Text = "Pode ser coletado"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Challenge_Content = {
    Text = "Cidade no lago"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Fill_Up_Content = {
    Text = "(Distância para encher:"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Finished_Content = {Text = "Concluído"},
  PanelText_UI_Events_Panel_Wanda_Text_C_Not_unlocked_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Pv_Content = {
    Text = "Reproduzir imagem"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Receive_Content = {
    Text = "Distância para coleta"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Record_Content = {
    Text = "Festa Ardente"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Resonance_Content = {
    Text = "Ressonância: Ordem de Substituição"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Shop_Content = {
    Text = "A Caixa de Tesouros Exóticos de Wanda"
  },
  PanelText_UI_Events_Panel_Wanda_Text_C_Topic_Content = {
    Text = "Festa Ardente"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Challenge_Content = {
    Text = "Requiem das Estrelas"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_ProgressTitle_Content = {
    Text = "Progresso do Estágio"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Rank_Content = {
    Text = "Tabela de líderes"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Record_Content = {
    Text = "Registro da força-tarefa"
  },
  PanelText_UI_Events_Panel_WorldBoss_Text_C_Topic_Content = {
    Text = "Decisivo: Sombra primordial"
  },
  PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Introduction_Content = {
    Text = "Do amor surge o ressentimento, do ressentimento surge o ódio, espesso, persistente e sombrio...\nOs céus não respondem às suas súplicas, e não há fuga sob a terra, assim a risada escondida na névoa da noite responde ao seu chamado, e você não precisa pagar nenhum preço. \nOlhe para ela, obedeça-a, funde-se com ela, torne-se ela."
  },
  PanelText_UI_Events_Panel_Xu_StageGroup_Text_C_Title_Content = {
    Text = "Matriarca Obsidiana"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_ChallengeTip_Content = {
    Text = "Jogo por Tempo Limitado"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Challenge_Content = {
    Text = "Matriarca Obsidiana"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_RecordTip_Content = {
    Text = "Acesso livre limitado"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Record_Content = {
    Text = "Navegação na consciência"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Reward_Content = {
    Text = "Recompensa de conquista"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Shop_Content = {
    Text = "Oferta Desolada"
  },
  PanelText_UI_Events_Panel_Xu_Text_C_Topic_Content = {
    Text = "Sussurros de Huangpu"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Awards_Content = {Text = "Prêmio"},
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_CurRate_Content = {
    Text = "Probabilidade atual"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_InitRate_Content = {
    Text = "Probabilidade inicial"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Item_Content = {
    Text = "Recompensa de item"
  },
  PanelText_UI_Events_Popup_ClotherLotteryRate_Text_C_Rate_Content = {
    Text = "probabilidade"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_Desc_Content = {
    Text = "Descrição do evento"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_InfoTitle_Content = {
    Text = "Resumo do Evento"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_OptionWeapon_Content = {
    Text = "Ver todas as rodas do destino disponíveis"
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_Slogan_Content = {
    Text = [[
Apenas 24 horas! 
Escolha um Despertado permanente!]]
  },
  PanelText_UI_Events_Popup_GiftBag_Text_C_SpecialTime_Content = {Text = "Restante"},
  PanelText_UI_Events_Popup_GiftBag_Text_PayTip_Content = {
    Text = "O preço exibido atualmente é o preço padrão da moeda, apenas para referência. Na hora do pagamento, prevalecerá a moeda e o preço reais."
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Name_1_Content = {
    Text = "Ver detalhes"
  },
  PanelText_UI_Events_Popup_Optional_Text_C_Name_2_Content = {Text = "Receber"},
  PanelText_UI_Events_Popup_Optional_Text_C_Title_Content = {
    Text = "Roda do destino escolhida"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistAwaker_Content = {
    Text = "Personagem de apoio"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_AssistCount_Content = {
    Text = "Número de apoios de batalha"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Assist_Content = {
    Text = "Ranking de Suporte"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Assist_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Empty_Kill_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Assist_Content = {
    Text = "Informações do Guardião"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Information_Kill_Content = {
    Text = "Informações do Guardião"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_KillCount_Content = {
    Text = "Contagem Total de Capturas"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Kill_Content = {
    Text = "Ranking de Guardiões"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Rank_Assist_Content = {
    Text = "Classificação"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Rank_Kill_Content = {
    Text = "Classificação"
  },
  PanelText_UI_Events_Popup_WorldBossRank_Text_C_Title_Content = {
    Text = "Tabela de líderes"
  },
  PanelText_UI_Events_RAID_StageGroup_Text_C_Introduction_Content = {
    Text = "Preto, preto, preto...\nOs Monstros negros como breu gritam, rugem e dançam freneticamente, avançando sobre você como uma maré.\n \"Pfft—\"\n\"Este mal tinha Prata. Lembre-se de trazer mais da próxima vez.\""
  },
  PanelText_UI_Events_RAID_StageGroup_Text_C_Title_Content = {
    Text = "Corrida de Prata do gato"
  },
  PanelText_UI_Events_Stage_Tip_Text_C_Title_Content = {
    Text = "Recompensa de Investigação"
  },
  PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Introduction_Content = {
    Text = "Preto, ondas negras continuam a avançar sem parar. \n Gatos enlouquecidos o cercam, vindo de incontáveis dimensões em sua direção."
  },
  PanelText_UI_Events_TeamSchool_StageGroup_Text_C_Title_Content = {
    Text = "Dança dos Gatos"
  },
  PanelText_UI_Events_WorldBoss_StageGroup_Text_C_Introduction_Content = {
    Text = [[
Enfrentem seu desespero primordial. Enfrentem seu medo primordial.
Fiquem ao lado um do outro invisivelmente e, em seguida, derrotem-no]]
  },
  PanelText_UI_Events_WorldBoss_StageGroup_Text_C_Title_Content = {
    Text = "Requiem das Estrelas"
  },
  PanelText_UI_Events_illustrate_Tip_Text_C_Title_Content = {
    Text = "Descrição dos Despertos"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Full_Content = {
    Text = "Materiais Prontos"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Goto_Content = {Text = "Ir"},
  PanelText_UI_GuideNote_Item_Material_Text_C_Source_Content = {
    Text = "Obter origem"
  },
  PanelText_UI_GuideNote_Item_Material_Text_C_Sweep_Content = {Text = "Reproduzir"},
  PanelText_UI_GuideNote_Item_Task_Text_C_Recieve_Content = {Text = "Receber"},
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Goto_Content = {Text = "Ir"},
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Source_Content = {
    Text = "Obter origem"
  },
  PanelText_UI_GuideNote_Item_Trinket_Text_C_Sweep_Content = {Text = "Reproduzir"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Change_Content = {Text = "Trocar"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Choose_Content = {
    Text = "Clique para selecionar"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Detail_Content = {Text = "Detalhes"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_ExcludeTalent_Content = {Text = "Talento"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Level_Content = {Text = "Nível"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_More_Content = {Text = "Mais"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_NoTask_Content = {
    Text = "Selecione um Corpo Desperto"
  },
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Skill_Content = {Text = "Habilidade"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Talent_Content = {Text = "Talento"},
  PanelText_UI_GuideNote_Panel_AwakerStrength_Text_C_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_Abyss_Content = {Text = "Ir"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_DailyChallenge_Content = {Text = "Ir"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_Pvp_Content = {Text = "Ir"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_RailyWay_Content = {Text = "Ir"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Goto_RotationMode_Content = {Text = "Ir"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Rank_Abyss_Content = {
    Text = "Classificação"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Abyss_Content = {
    Text = "Recompensas Restantes"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_DailyChallenge_Content = {
    Text = "Recompensa de Ranking"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_Pvp_Content = {
    Text = "Recompensa de Ranking"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RailyWay_Content = {
    Text = "Recompensa de Ranking"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Reward_RotationMode_Content = {
    Text = "Recompensa de Ranking"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_DailyChallenge_Content = {Text = "Pontos"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_Pvp_Content = {Text = "Pontos"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RailyWay_Content = {
    Text = "Pts Mais Altos"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Score_RotationMode_Content = {Text = "Pontos"},
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Abyss_Content = {
    Text = "Zona D-efeito"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_DailyChallenge_Content = {
    Text = "Mergulho fantasmal"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_Pvp_Content = {
    Text = "Fase de Duelo – Pré-formação"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RailyWay_Content = {
    Text = "Trem de Alegria Acelerado"
  },
  PanelText_UI_GuideNote_Panel_PermTrain_Text_C_Title_RotationMode_Content = {
    Text = "Fase de Duelo – Modo de seleção da roda"
  },
  PanelText_UI_GuideNote_PermTrainBase_Text_C_Goto_Content = {Text = "Ir"},
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Goto_Content = {Text = "Ir"},
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ItemsPreview_Content = {
    Text = "Pré-visualização de Recursos Restantes"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Null_Content = {
    Text = "Sem Recursos Restantes"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_ProgressTitle_Content = {
    Text = "Progresso de Jogo"
  },
  PanelText_UI_GuideNote_Popup_ResSummary_Text_C_Title_Content = {
    Text = "Operação de investigação"
  },
  PanelText_UI_Guide_ChangeName_Image_Confim_Dis_Bg_Content = {Text = "Gravação"},
  PanelText_UI_Guide_ChangeName_Text_C_Confim_Dis_Content = {Text = "Assinatura"},
  PanelText_UI_Guide_ChangeName_Text_C_Confim_Nor_Content = {Text = "Assinatura"},
  PanelText_UI_Guide_ChangeName_Text_C_Myself_Content = {Text = "Seu nome"},
  PanelText_UI_Guide_ChangeName_Text_C_Return_Content = {
    Text = "Voltar à seleção de gênero"
  },
  PanelText_UI_Guide_ChangeName_Text_C_Tips_Content = {
    Text = "Insira seu nome"
  },
  PanelText_UI_Guide_ChangeName_Text_Confim_Nor_Content = {Text = "Gravação"},
  PanelText_UI_Home_Panel_Main_Text_C_Title_Content = {
    Text = "Centro de pesquisa"
  },
  PanelText_UI_Homeland_Item_Building_Text_C_Done_Content = {Text = "Cheio"},
  PanelText_UI_Homeland_Panel_Main_Text_C_Tips_Content = {
    Text = "Visão geral dos bônus"
  },
  PanelText_UI_InvitationCode_Item_Player_Text_Name_Content = {Text = "Receber"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_BindingTip_Content = {
    Text = "Vincule-se ao Guardião do Caminho, em um universo repleto de inúmeras Chaves de Prata brilhantes, você não está sozinho."
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_High_Content = {
    Text = "Vinculação de convite"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Binding_Nor_Content = {
    Text = "Vinculação de convite"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Clean_Content = {Text = "Eliminar"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Condition_Content = {
    Text = "Os Guardiões convidados, ao atingirem os níveis 5/10/15/20, podem receber recompensas de Resplandor da Chave de Prata."
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Copy_Content = {Text = "Copiar"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Desc_Content = {
    Text = "Copie o código de convite e leve almas do universo infinito para embarcar na jornada da corrosão."
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InputTip_Content = {
    Text = "Preencha o código de convite exclusivo do amigo e receba imediatamente"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InviteCount_Content = {
    Text = "Número de pessoas convidadas"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_High_Content = {
    Text = "Evento de convite"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Invite_Nor_Content = {
    Text = "Evento de convite"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_InvitedCount_Content = {Text = "300!"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_MyCode_Content = {
    Text = "Meu código de convite"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Paste_Content = {Text = "Colar"},
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Share_Content = {
    Text = "Compartilhar"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Tips_Content = {
    Text = "Digite o código de convite"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_Value_Content = {
    Text = "Resplandor da Chave de Prata"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_C_illustrate_Content = {
    Text = "Descrição do evento"
  },
  PanelText_UI_InvitationCode_Popup_Main_Text_Title_Content = {
    Text = "Evento de convite"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Null_Content = {
    Text = "Nenhum Guardião convidado atingiu o nível 5"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Title2_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_InvitationCode_Popup_PlayerList_Text_C_Title_Content = {
    Text = "Lista de Convites"
  },
  PanelText_UI_Keeper_Panel_Acquire_Text_C_Acquire_Content = {
    Text = "Obter Nova Chave"
  },
  PanelText_UI_Keeper_Panel_Acquire_Text_C_Tips_Content = {
    Text = "Clique na tela para fechar"
  },
  PanelText_UI_Keeper_Skill_Item_Text_C_Current_Content = {
    Text = "Usando atualmente"
  },
  PanelText_UI_Keeper_Skill_Item_Text_C_Disable_Content = {
    Text = "Não pode ser usado"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_Name_1_Content = {Text = "Escolher"},
  PanelText_UI_Keeper_Skill_Panel_Text_C_Name_2_Content = {Text = "Cancelar"},
  PanelText_UI_Keeper_Skill_Panel_Text_C_NoTask_Content = {
    Text = "Nenhuma Ordem de chave"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_C_Title_Content = {
    Text = "Ordem de chave"
  },
  PanelText_UI_Keeper_Skill_Panel_Text_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Login_Panel_ServerSelect_Text_Panel_Title_Content = {
    Text = "Seleção de servidores"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Activity_Content = {
    Text = "Aviso do evento"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_BugFix_Content = {
    Text = "Problema Reparado"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Game_Content = {Text = "Anúncio"},
  PanelText_UI_Login_Popup_Tips_Text_C_Title2_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Login_Popup_Tips_Text_C_Title_Content = {Text = "Sem avisos"},
  PanelText_UI_Login_Popup_Tips_Text_C_Title_En_Content = {
    Text = "Caixa de correio vazia"
  },
  PanelText_UI_Login_Popup_Tips_Text_Title_Content = {Text = "Anúncio"},
  PanelText_UI_Login_Text_C_Announcement_Content = {Text = "Anúncio"},
  PanelText_UI_Login_Text_C_Deal_Content = {Text = "Acordo"},
  PanelText_UI_Login_Text_C_Enter_Content = {
    Text = "Entrar na universidade"
  },
  PanelText_UI_Login_Text_C_Fight_Content = {
    Text = "Batalha 2.0"
  },
  PanelText_UI_Login_Text_C_Plot_Content = {
    Text = "Teste de enredo Avg"
  },
  PanelText_UI_Login_Text_C_Quit_Content = {Text = "Sair"},
  PanelText_UI_Login_Text_C_Repair_Content = {Text = "Reparar"},
  PanelText_UI_Login_Text_C_Service_Content = {
    Text = "Suporte ao cliente"
  },
  PanelText_UI_Login_Text_C_Set_Content = {
    Text = "Configurações"
  },
  PanelText_UI_Login_Text_C_Setting_Content = {
    Text = "Configurações"
  },
  PanelText_UI_Login_Text_C_Sweep_Content = {
    Text = "Escanear código"
  },
  PanelText_UI_Login_Text_C_Title1_Content = {
    Text = "Véspera do Esquecimento"
  },
  PanelText_UI_Login_Text_C_User_Content = {
    Text = "Centro do Usuário"
  },
  PanelText_UI_Mail_Text_C_All_Content = {
    Text = "Receber tudo"
  },
  PanelText_UI_Mail_Text_C_Collection_Content = {
    Text = "E-mails salvos"
  },
  PanelText_UI_Mail_Text_C_Delete01_Content = {Text = "Excluir"},
  PanelText_UI_Mail_Text_C_Delete_Content = {
    Text = "Excluir lidos"
  },
  PanelText_UI_Mail_Text_C_Empty_Content = {
    Text = "Sem novos e-mails"
  },
  PanelText_UI_Mail_Text_C_Mail_Content = {
    Text = "Número de e-mails"
  },
  PanelText_UI_Mail_Text_C_Name_Content = {Text = "Receber"},
  PanelText_UI_Mail_Text_C_NoTask1_Content = {
    Text = "Sem mensagens"
  },
  PanelText_UI_Mail_Text_C_Select_Letter_Content = {
    Text = "Escolha um e-mail"
  },
  PanelText_UI_Mail_Text_C_Time_Content = {Text = "Tempo:"},
  PanelText_UI_Mail_Text_C_Tips_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Mail_Text_C_Title_Content = {
    Text = "Caixa de correio"
  },
  PanelText_UI_Mail_Text_Time2_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Mail_Text_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Close_Content = {
    Text = "Clique na tela para fechar"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Daily_Content = {
    Text = "Treinamento diário"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Finish_Content = {
    Text = "Concluído hoje"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Receive_Content = {Text = "Recebido"},
  PanelText_UI_Main_Daily_Tips_Text_C_Reward_Content = {
    Text = "Recompensa concluída"
  },
  PanelText_UI_Main_Daily_Tips_Text_C_Skill_Tag_Content = {
    Text = "Caminho de Investigação"
  },
  PanelText_UI_Main_Favor_Tip_Text_C_Name_Content = {
    Text = "Taxa de Sincronização"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Awaken_Content = {
    Text = "Data de despertar"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Favor_Content = {
    Text = "Taxa de afinidade atual"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Tip_Content = {
    Text = "Após convidar o despertador, a taxa de afinidade desse despertador aumenta a cada intervalo de tempo"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_C_Title_Content = {
    Text = "Dormitório"
  },
  PanelText_UI_Main_Helicopter_Tips_Text_Name_1_Content = {Text = "Convidar"},
  PanelText_UI_Main_Helicopter_Tips_Text_Name_2_Content = {Text = "Cancelar"},
  PanelText_UI_Main_Helicopter_Tips_Text_ResetBg_Content = {
    Text = "Áudio e vídeo padrão"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Not_Content = {Text = "Incompleto"},
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Proxy_Content = {
    Text = "Credencial de agente"
  },
  PanelText_UI_Main_Item_ActiveTasks_Text_C_Receive_Content = {Text = "Receber"},
  PanelText_UI_Main_Panel_1_Text_Abyss_Content = {
    Text = "Zona D-efeito"
  },
  PanelText_UI_Main_Panel_1_Text_C_Acclaim_Content = {
    Text = "Avaliação positiva"
  },
  PanelText_UI_Main_Panel_1_Text_C_Activity_Content = {Text = "Evento"},
  PanelText_UI_Main_Panel_1_Text_C_Awaker_Content = {
    Text = "Corpo Desperto"
  },
  PanelText_UI_Main_Panel_1_Text_C_Bag_Content = {
    Text = "Inventário"
  },
  PanelText_UI_Main_Panel_1_Text_C_Close_1_Content = {Text = "Fechando"},
  PanelText_UI_Main_Panel_1_Text_C_Close_Content = {Text = "Fechando"},
  PanelText_UI_Main_Panel_1_Text_C_Collection_Content = {Text = "Biblioteca"},
  PanelText_UI_Main_Panel_1_Text_C_Community_Content = {Text = "Comunidade"},
  PanelText_UI_Main_Panel_1_Text_C_Daily_Content = {
    Text = "Treinamento diário"
  },
  PanelText_UI_Main_Panel_1_Text_C_Dbg_Content = {
    Text = "Interlúdio"
  },
  PanelText_UI_Main_Panel_1_Text_C_DungeonNote_Content = {
    Text = "Notas do domínio"
  },
  PanelText_UI_Main_Panel_1_Text_C_Formation_Content = {Text = "Formação"},
  PanelText_UI_Main_Panel_1_Text_C_Full_Content = {Text = "Concluído"},
  PanelText_UI_Main_Panel_1_Text_C_GamePassport_Content = {
    Text = "Diário do Guardião do Segredo"
  },
  PanelText_UI_Main_Panel_1_Text_C_Lesson_Content = {Text = "Currículo"},
  PanelText_UI_Main_Panel_1_Text_C_Main_Content = {
    Text = "Investigação"
  },
  PanelText_UI_Main_Panel_1_Text_C_Mission_Content = {Text = "Registros"},
  PanelText_UI_Main_Panel_1_Text_C_Pvp_Content = {
    Text = "Fase de Duelo\n"
  },
  PanelText_UI_Main_Panel_1_Text_C_Recall_Content = {Text = "Fliperama"},
  PanelText_UI_Main_Panel_1_Text_C_Recruit_Content = {Text = "Despertar"},
  PanelText_UI_Main_Panel_1_Text_C_Recruit_Nor_Content = {Text = "Despertar"},
  PanelText_UI_Main_Panel_1_Text_C_Store_Content = {
    Text = "Loja de Misaka"
  },
  PanelText_UI_Main_Panel_1_Text_C_Welfare_Content = {
    Text = "Benefícios em grande quantidade, obtenha por tempo limitado"
  },
  PanelText_UI_Main_Panel_1_Text_Diving_Content = {
    Text = "Mergulho fantasmal"
  },
  PanelText_UI_Main_Popup_ActiveTasks_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Main_Popup_ActiveTasks_Text_C_Title_Content = {
    Text = "Missão de Treinamento"
  },
  PanelText_UI_Michi_Popup_Strengthen_Succeed_Text_C_Info_Content = {
    Text = "Clique no espaço em branco para fechar"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Consume_Content = {Text = "Consumo"},
  PanelText_UI_Other_Donate_Tips_Text_C_Donated_Content = {
    Text = "Total doado"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Fund_Content = {
    Text = "Fundo de doação de ex-alunos"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Least_Content = {Text = "Mínimo"},
  PanelText_UI_Other_Donate_Tips_Text_C_Title_Content = {
    Text = "Doação de primordial de prata"
  },
  PanelText_UI_Other_Donate_Tips_Text_C_Utmost_Content = {Text = "Máximo"},
  PanelText_UI_Other_Fund_Tips_Text_C_Describe_Content = {
    Text = "Doe Líquido de Origem de Núcleo de Prata, acumule contribuição, sua bondade será recompensada. Seu \"valor total de contribuição\" é a soma dos Líquidos de Origem de Núcleo de Prata doados."
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Donated_Content = {
    Text = "Contribuição total atual"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_Title_Content = {
    Text = "Fundo de doação de ex-alunos"
  },
  PanelText_UI_Other_Fund_Tips_Text_C_illustrate_Content = {Text = "Regras"},
  PanelText_UI_Other_Physical_Tips_Text_C_All_Content = {
    Text = "Restaurar tudo:"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Auto_Content = {
    Text = "Recuperação automática"
  },
  PanelText_UI_Other_Physical_Tips_Text_C_Name_1_Content = {Text = "Cancelar"},
  PanelText_UI_Other_Physical_Tips_Text_C_Name_2_Content = {Text = "Confirmar"},
  PanelText_UI_Other_Physical_Tips_Text_C_Name_Content = {Text = "Cancelar"},
  PanelText_UI_Other_Physical_Tips_Text_C_Next_Content = {
    Text = "Próxima recuperação:"
  },
  PanelText_UI_Other_Physical_Tips_Text_Name_Content = {Text = "Cancelar"},
  PanelText_UI_Other_Popup_Key_Obtain_Text_C_Energy_Content = {
    Text = "Consumir Energia:"
  },
  PanelText_UI_Other_Popup_Key_Obtain_Text_C_Info_Content = {
    Text = "Clique no espaço em branco para fechar"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Next_Content = {
    Text = "Consumir Cristais de Núcleo de Prata"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Cost_Title_Now_Content = {
    Text = "Cristal de prata atual"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Question_Content = {
    Text = "Quer obter a chave?"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Next_Content = {
    Text = "Chave exausta"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Restore_Title_Now_Content = {
    Text = "Portador da chave"
  },
  PanelText_UI_Other_Popup_Key_Time_Revert_Text_C_Title_Content = {
    Text = "Obtenção de chave"
  },
  PanelText_UI_Other_Popup_Trinket_LevelUp_Text_C_Success_Content = {
    Text = "Reforço bem-sucedido"
  },
  PanelText_UI_PVP_Item_RotationPlayer_Text_C_HP_Content = {
    Text = "Quantidade de sangue"
  },
  PanelText_UI_PVP_Item_RotationPlayer_Text_C_Wait_Content = {
    Text = "Aguarde a exibição das informações do rodízio"
  },
  PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Attack_Content = {
    Text = "Primeiro ataque"
  },
  PanelText_UI_PVP_Item_RotationTeamInfo_Text_C_Defend_Content = {
    Text = "Contra-ataque"
  },
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_Adjust_Content = {
    Text = "Clique para mudar a posição do despertador"
  },
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_My_Content = {Text = "Pronto!"},
  PanelText_UI_PVP_Panel_Rotation_Adjust_Text_C_StandBy_Other_Content = {Text = "Pronto!"},
  PanelText_UI_PVP_Panel_TeamRotation_Text_BtnName_Content = {
    Text = "Selecionado"
  },
  PanelText_UI_Passport_Choose_Tip_Text_C_Title_Content = {
    Text = "Escolha a recompensa"
  },
  PanelText_UI_Passport_Exchange_Text_C_Buy_Title_Content = {
    Text = "Aumentar nível"
  },
  PanelText_UI_Passport_Exchange_Text_C_Cost_Tips_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Passport_Exchange_Text_C_Title_Content = {
    Text = "Aumentar nível do projeto"
  },
  PanelText_UI_Passport_Exchange_Text_C_Title_En_Content = {
    Text = "Suba de nível."
  },
  PanelText_UI_Passport_Instructions_Text_C_Remainder_Content = {
    Text = "Tempo restante desta edição"
  },
  PanelText_UI_Passport_Instructions_Text_C_Title_Content = {Text = "Currículo"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Additional_Content = {
    Text = "Desbloquear e obter imediatamente"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Condition_Content = {
    Text = "Complete todos os tópicos para acumular recompensas"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_1_Content = {
    Text = "Aumenta imediatamente"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_3_Content = {Text = "Nível"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_4_Content = {
    Text = "Nível da Tarefa"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Hoist_Content = {
    Text = "Aumente imediatamente <color=#5EF2FF><size=32>10</size> níveis</color> no nível do curso"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Introduce_Content = {
    Text = "Desbloqueie tópicos avançados e suba para o nível 40, então selecione uma roda do destino ou \"Núcleo Luminoso\" ×5 como recompensa na caixa de honra do currículo"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Name_Content = {
    Text = "Ordem de treinamento"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_1_Content = {
    Text = "Diárias\nRecompensas ×3"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_2_Content = {
    Text = [[
Turno de batalha 
 Retroceder]]
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_3_Content = {
    Text = "Fase de Duelo\ntodas as cartas disponíveis"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Privilege_Content = {
    Text = "Compre para Desbloquear Privilégios Durante Este Registro de temas:"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Prompt_Content = {
    Text = "Divirta-se com moderação, consuma com responsabilidade"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_1_Content = {Text = "Comprado"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Purchase_2_Content = {Text = "Comprado"},
  ["PanelText_UI_Passport_Money_Item_New_Text_C_Senior (1)_Content"] = {Text = "Avançado"},
  PanelText_UI_Passport_Money_Item_New_Text_C_Senior_Content = {
    Text = "Tema avançado"
  },
  ["PanelText_UI_Passport_Money_Item_New_Text_C_Super (1)_Content"] = {
    Text = "Classe Especial"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_Super_Content = {
    Text = "Tema principal"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_TempUnlock_Content = {
    Text = "Receba imediatamente recompensas exclusivas por tópicos premium"
  },
  PanelText_UI_Passport_Money_Item_New_Text_C_ThisIssue_Content = {
    Text = "Complete todos os tópicos para acumular recompensas"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Condition_Content = {
    Text = "Recompensa disponível após subir de nível"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_1_Content = {
    Text = "Aumenta imediatamente"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_3_Content = {Text = "Nível"},
  PanelText_UI_Passport_Money_Item_Text_C_Hoist_4_Content = {
    Text = "Nível da Tarefa, e obteve"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Introduce_Content = {
    Text = "Caixa de presente requintada contendo uma preciosa Roda do destino, feita à mão.\nDesbloqueie o Tema avançado e alcance o nível 40 para escolher uma Roda do destino ou Núcleo de Lumen ×5."
  },
  PanelText_UI_Passport_Money_Item_Text_C_Name_Content = {
    Text = "Caixa de presente de tarefa"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Prompt_Content = {
    Text = "Divirta-se com moderação, consuma com responsabilidade"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Purchase_1_Content = {Text = "Comprado"},
  PanelText_UI_Passport_Money_Item_Text_C_Purchase_2_Content = {Text = "Comprado"},
  ["PanelText_UI_Passport_Money_Item_Text_C_Senior (1)_Content"] = {Text = "Avançado"},
  PanelText_UI_Passport_Money_Item_Text_C_Senior_Content = {
    Text = "Tema avançado"
  },
  ["PanelText_UI_Passport_Money_Item_Text_C_Super (1)_Content"] = {
    Text = "Classe Especial"
  },
  PanelText_UI_Passport_Money_Item_Text_C_Super_Content = {
    Text = "Tema principal"
  },
  PanelText_UI_Passport_Money_Item_Text_C_ThisIssue_Content = {
    Text = "Inclui todo o conteúdo do tópico avançado atual"
  },
  PanelText_UI_Passport_Panel_Main_New_Text_C_Mail_Content = {Text = "Regras"},
  PanelText_UI_Passport_Panel_Main_New_Text_C_Title_Content = {Text = "Currículo"},
  PanelText_UI_Passport_Panel_Main_Text_C_Experience_Content = {
    Text = "Experiência da Tarefa"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Full_Content = {
    Text = "Nível máximo"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Instructions_Grade_Content = {
    Text = "Nível da Tarefa"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Mail_Content = {Text = "Regras"},
  PanelText_UI_Passport_Panel_Main_Text_C_Name_Content = {
    Text = "Aumentar nível"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Online_Content = {
    Text = "Limite de experiência semanal"
  },
  PanelText_UI_Passport_Panel_Main_Text_C_Title_Content = {Text = "Currículo"},
  PanelText_UI_Passport_Popup_Player_LevelUp_Text_C_Title_Content = {
    Text = "Nível da Tarefa aumentado"
  },
  PanelText_UI_Passport_Popup_Recharge_Text_Cancel_Name_Content = {Text = "Cancelar"},
  PanelText_UI_Passport_Popup_Recharge_Text_Confirm_Name_Content = {Text = "Confirmar"},
  PanelText_UI_Passport_Popup_Recharge_Text_Title_Content = {
    Text = "Confirmação de compra"
  },
  PanelText_UI_Passport_Praising_Item_Text_C_Content_Content = {
    Text = "Caixa de presente requintada contendo uma preciosa Roda do destino, feita à mão.\nDesbloqueie o Tema avançado e alcance o nível 40 para escolher uma Roda do destino ou Núcleo de Lumen ×5."
  },
  PanelText_UI_Passport_Praising_Item_Text_C_Title_Content = {
    Text = "Caixa de presente de tarefa"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Experience_Content = {
    Text = "Experiência da Tarefa"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Full_Content = {
    Text = "Nível máximo"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_GainExperience_Content = {
    Text = "Ganhar Experiência"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Name_2_Content = {
    Text = "Nível de compra"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Name_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Online_Content = {
    Text = "Limite semanal"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Ordinary_Title_Content = {
    Text = "Cursos básicos"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Content = {
    Text = "Nível avançado do tema"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Senior_Title_Content = {
    Text = "Tema avançado"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Timing_Content = {
    Text = "Esta edição"
  },
  PanelText_UI_Passport_Reward_Item_New_Text_C_Unlock_Content = {
    Text = "Desbloquear e obter imediatamente"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Experience_Content = {
    Text = "Experiência da Tarefa"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Full_Content = {
    Text = "Nível máximo"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Name_2_Content = {
    Text = "Nível de compra"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Name_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Online_Content = {
    Text = "Limite semanal"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Ordinary_Title_Content = {
    Text = "Cursos básicos"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Senior_Content = {
    Text = "Nível avançado do tema"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Senior_Title_Content = {
    Text = "Tema avançado"
  },
  PanelText_UI_Passport_Reward_Item_Text_C_Tab_Special_Content = {Text = "Avançado"},
  PanelText_UI_Passport_Reward_Item_Text_C_Timing_Content = {
    Text = "Tempo restante desta edição"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Introduce_Content = {
    Text = "Desbloqueie tópicos avançados e suba para o nível 40, então selecione uma roda do destino ou \"Núcleo Luminoso\" ×5 como recompensa na caixa de honra do currículo"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Reward_Content = {
    Text = "Prévia da caixa de presentes desta edição"
  },
  PanelText_UI_Passport_Show_Item_Text_C_Time_1_Content = {
    Text = "Tempo restante do evento desta edição"
  },
  PanelText_UI_Passport_Task_Choose_Text_C_Double_Content = {
    Text = "Experiência dupla"
  },
  PanelText_UI_Passport_Task_Choose_Text_C_Tab_Special_Content = {Text = "Evento"},
  PanelText_UI_Passport_Task_Description_Text_C_Name_Content = {Text = "Receber"},
  PanelText_UI_Passport_Task_Description_Text_C_Tab_Special_Content = {Text = "Evento"},
  PanelText_UI_Passport_Task_Item_Text_C_Experience_Content = {
    Text = "Experiência da Tarefa"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Full_Content = {
    Text = "Nível máximo"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Name_3_Content = {
    Text = "Nível de compra"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Name_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Online_Content = {
    Text = "Limite semanal"
  },
  PanelText_UI_Passport_Task_Item_Text_C_Time_Content = {
    Text = "Tempo restante desta edição"
  },
  PanelText_UI_Passport_illustrate_Tip_Text_C_Title_Content = {Text = "Regras"},
  PanelText_UI_Pocket_Mail_Text_C_Del_Content = {Text = "Excluir"},
  PanelText_UI_Pocket_Mail_Text_C_Time_Content = {Text = "Tempo:"},
  PanelText_UI_Pocket_Mail_Text_C_Tips_Content = {
    Text = "Número de Coleções"
  },
  PanelText_UI_Pocket_Mail_Text_C_Title2_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Pocket_Mail_Text_C_Title_Content = {
    Text = "Sem mensagens"
  },
  PanelText_UI_Pocket_Mail_Text_C_select_Title_Content = {
    Text = "Escolha uma carta"
  },
  PanelText_UI_Popup_DonationBox_Text_C_Reward_Content = {
    Text = "Inventário"
  },
  PanelText_UI_Popup_DonationBox_Text_C_SpeedTitle_Content = {
    Text = "Velocidade de obtenção:"
  },
  PanelText_UI_Protagonist_Item_Skill_Text_C_Current_Content = {Text = "Atual"},
  PanelText_UI_Protagonist_Item_Skill_Text_C_No_Content = {
    Text = "Não obtido"
  },
  PanelText_UI_Pvp_Blood_Share_Text_C_Release_Content = {
    Text = "Clique para liberar"
  },
  PanelText_UI_Pvp_Item_Card_Text_C_Replace_Content = {Text = "Substituir"},
  PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Done_Content = {Text = "Me segue"},
  PanelText_UI_Pvp_Item_Collection_Comment_Text_C_Mutual_Content = {
    Text = "Seguir mutuamente"
  },
  PanelText_UI_Pvp_Item_Dan_Text_C_Current_Content = {Text = "Rank atual"},
  PanelText_UI_Pvp_Item_Formation_Text_C_Conflict_Content = {
    Text = "Conflito de posicionamento"
  },
  PanelText_UI_Pvp_Item_List_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Double_Content = {
    Text = "Benefícios em dobro"
  },
  PanelText_UI_Pvp_Item_Out_Obtain_Text_C_Tab_Topic_Content = {
    Text = "Privilégio da Tarefa"
  },
  PanelText_UI_Pvp_Item_Ranking_Text_C_Current_Content = {
    Text = "Recompensa atual"
  },
  PanelText_UI_Pvp_Item_Role_Text_C_Decks_Content = {Text = "Deck"},
  PanelText_UI_Pvp_Item_Role_Text_C_Maniac_Content = {Text = "Fúria"},
  PanelText_UI_Pvp_Item_Role_Text_C_Role_Wins_Content = {Text = "Vitórias"},
  PanelText_UI_Pvp_Panel_Battle_Text_High_Content = {Text = "Render-se"},
  PanelText_UI_Pvp_Panel_Collection_Comment_Text_C_NoTask_Content = {
    Text = "Sem comentários"
  },
  PanelText_UI_Pvp_Panel_Collection_Comment_Text_Time_Content = {
    Text = "Faça o primeiro comentário"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Decks_Content = {Text = "Deck"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Effect_Content = {Text = "Efeito"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Hoist_Content = {
    Text = "Consumo de potência de cálculo"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Maniac_Content = {Text = "Fúria"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_TotalWins_Content = {
    Text = "Total de vitórias"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Role_Wins_Content = {
    Text = "Vitórias da Temporada"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Skill_Tag_Content = {
    Text = "Fúria Explosiva"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Source_Content = {Text = "Origem"},
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_TotalWins_Content = {
    Text = "Total de vitórias"
  },
  PanelText_UI_Pvp_Panel_Collection_Detail_Text_C_Wins_Content = {
    Text = "Total de vitórias nesta temporada"
  },
  PanelText_UI_Pvp_Panel_Collection_List_Text_C_None_Content = {
    Text = "Sem coleções relacionadas"
  },
  PanelText_UI_Pvp_Panel_Collection_List_Text_C_Time_Content = {
    Text = "Este reino ainda não está aberto para a traphase"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Awaker_Name_Content = {
    Text = "Corpo Desperto"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_KeeperSkill_Name_Content = {
    Text = "Ordem de chave"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_1_Content = {Text = "Detalhes"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_2_Content = {Text = "Ranking"},
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Toggle_3_Content = {
    Text = "Comentários"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Train_Name_Content = {
    Text = "Teste dos Despertos"
  },
  PanelText_UI_Pvp_Panel_Collection_Main_Text_C_Weapon_Name_Content = {
    Text = "Roda do destino"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_NoTask_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_SeasonWins_Content = {
    Text = "Vitórias da Temporada"
  },
  PanelText_UI_Pvp_Panel_Collection_Rank_Text_C_TotalWins_Content = {
    Text = "Total de vitórias"
  },
  PanelText_UI_Pvp_Panel_Detail_Text_C_Decks_Content = {Text = "Deck"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Effect_Content = {Text = "Efeito"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Maniac_Content = {Text = "Fúria"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Role_Wins_Content = {Text = "Vitórias"},
  PanelText_UI_Pvp_Panel_Detail_Text_C_Wins_Content = {Text = "Vitórias"},
  PanelText_UI_Pvp_Panel_Formation_Text_C_Detail_Content = {
    Text = "Por favor, escolha a entrada à esquerda"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_1_Content = {
    Text = "Por favor, escolha a entrada à esquerda"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Empty_Content = {
    Text = "Por favor, escolha a entrada à esquerda"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Name_Content = {Text = "Detalhes"},
  PanelText_UI_Pvp_Panel_Formation_Text_C_None2_Content = {
    Text = "Ainda sem material"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_None_Content = {
    Text = "Sem resultados de filtragem relacionados"
  },
  PanelText_UI_Pvp_Panel_Formation_Text_C_Time_Content = {
    Text = "Pode ser obtido por meios específicos"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Award_Content = {
    Text = "Recompensa de vitórias"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_CardEdit_Content = {
    Text = "Pré-grupo lineup"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Robot_Content = {Text = "Fechar"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Close_Speed_Content = {Text = "Fechar"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Collection_Content = {Text = "Coleção"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_DraftPick_Content = {
    Text = "Nível de rodízio"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Expression_Content = {
    Text = "Expressão de combate"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Integral_Content = {
    Text = "Pontuação da temporada"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Matching_Content = {
    Text = "Iniciar pareamento"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Robot_Content = {Text = "Ativar"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Open_Speed_Content = {Text = "Ativar"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Password_Content = {
    Text = "Combate de senha"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Precon_Content = {
    Text = "Nível de Pré-formação"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Progress_Content = {
    Text = "Recompensa de classificação"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Content = {
    Text = "Selecionar tudo"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Pvp_Score_Content = {Text = "Pontos"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Ranking_Content = {
    Text = "Tabela de Ranking"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Record_Content = {
    Text = "Recorde de Xadrez"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Reward_Content = {
    Text = "Alcance um nível mais alto para obter mais recompensas"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Robot_Content = {
    Text = "Rival Simulado"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Content = {
    Text = "Escolha do draft"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_RotationMode_Score_Content = {Text = "Pontos"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Rule_Content = {Text = "Regras"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Speed_Content = {
    Text = "Partida precisa"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Store_Content = {Text = "Loja"},
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Time_Content = {
    Text = "Temporada restante"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Title_Content = {
    Text = "Fase de Duelo"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Victory_Content = {
    Text = "Vitórias acumuladas:"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_Weekly_Content = {
    Text = "Recompensa semanal"
  },
  PanelText_UI_Pvp_Panel_Main_1_Text_C_list_Content = {Text = "Ranking"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Name_Content = {Text = "Fim"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Unclickable_Content = {Text = "Fim"},
  PanelText_UI_Pvp_Panel_Main_Text_C_Zongshanghai_Content = {Text = "Dano Total"},
  PanelText_UI_Pvp_Panel_Match_Text_C_Second_Content = {Text = "Segundos"},
  PanelText_UI_Pvp_Panel_Match_Text_C_Win_Content = {
    Text = "Correspondência bem-sucedida"
  },
  PanelText_UI_Pvp_Panel_Match_Text_Name_Content = {
    Text = "Iniciar pareamento"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Huodewuzi_Content = {
    Text = "Recompensa de liquidação"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Integral_Content = {
    Text = "Pontuação da temporada"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Show_Content = {
    Text = "Próximo passo"
  },
  PanelText_UI_Pvp_Panel_Out_Text_C_Sync_Content = {
    Text = "A taxa de afinidade do despertador aumentou"
  },
  PanelText_UI_Pvp_Panel_Playback_Text_C_Angle_Content = {
    Text = "Mudar perspectiva"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_1_Content = {Text = "Seguir"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Attention_2_Content = {Text = "Seguir"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_1_Content = {Text = "Elogio"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Commend_2_Content = {Text = "Elogiado"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Enemy_Content = {Text = "Inimigo"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Fail_Content = {Text = "Falha"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Harm_Content = {Text = "Dano"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Ourside_Content = {Text = "Nosso lado"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Outcome_Content = {Text = "Vitória"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_OwnRespectable_Content = {
    Text = "Adversário digno!"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Point_01_Content = {Text = "Minuto"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Point_02_Content = {Text = "Minuto"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Respectable_Content = {
    Text = "Adversário digno!"
  },
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Shields_Content = {Text = "Escudo"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Treat_Content = {Text = "Curar"},
  PanelText_UI_Pvp_Panel_Settlement_Text_C_Victory_Content = {Text = "Vitória"},
  PanelText_UI_Pvp_Panel_Train_Text_C_KeeperSkills_Content = {
    Text = "Adicionar Chave"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_Position_Content = {
    Text = "Deslocamento"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_Reset_Content = {Text = "Resetar"},
  PanelText_UI_Pvp_Panel_Train_Text_C_SelectRelic_Content = {
    Text = "Escolha criação"
  },
  PanelText_UI_Pvp_Panel_Train_Text_C_Weapons_Content = {
    Text = "Adicionar roda do destino"
  },
  PanelText_UI_Pvp_Panel_lineup_Show_Text_C_Point_01_Content = {Text = "Minuto"},
  PanelText_UI_Pvp_Panel_lineup_Show_Text_C_Point_02_Content = {Text = "Minuto"},
  PanelText_UI_Pvp_Popup_Breaking_Text_C_Breaking_Content = {
    Text = "Conexão com o servidor foi desconectada"
  },
  PanelText_UI_Pvp_Popup_Breaking_Text_C_Quit_Content = {
    Text = "Voltar à tela de login"
  },
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Decks_Content = {Text = "Deck"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Effect_Content = {Text = "Efeito"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Maniac_Content = {Text = "Fúria"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Role_Wins_Content = {Text = "Vitórias"},
  PanelText_UI_Pvp_Popup_Collection_Detail_Text_C_Wins_Content = {Text = "Vitórias"},
  PanelText_UI_Pvp_Popup_Dan_Text_C_Bonus_Content = {
    Text = "Bônus de temporada"
  },
  PanelText_UI_Pvp_Popup_Dan_Text_C_Continue_Content = {
    Text = "Clique para continuar"
  },
  PanelText_UI_Pvp_Popup_Dan_Text_C_Streak_Content = {
    Text = "Bônus de Vitória Contínua"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Title_Content = {
    Text = "Despertar Espiritual"
  },
  PanelText_UI_Pvp_Popup_Enlightenment_Adjust_Text_C_Use_Content = {Text = "Em uso"},
  PanelText_UI_Pvp_Popup_Enlightenment_Tips_Text_C_Title_Content = {
    Text = "Despertar Espiritual"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Content = {
    Text = "Gerenciamento de expressão"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Content = {
    Text = "Expressão História"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Overview_Sel_Content = {
    Text = "Expressão História"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Emoji_Sel_Content = {
    Text = "Gerenciamento de expressão"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Title_Content = {
    Text = "Gerenciamento de expressão"
  },
  PanelText_UI_Pvp_Popup_Expression_Manage_Text_C_Use_Content = {
    Text = "Expressão de combate"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Close_Content = {
    Text = "Clique no espaço em branco para continuar"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Continue_Content = {
    Text = "Clique para continuar"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_C_Fail_Content = {Text = "Falha"},
  PanelText_UI_Pvp_Popup_Fail_Text_C_Victory_Content = {
    Text = "Derrota na batalha"
  },
  PanelText_UI_Pvp_Popup_Fail_Text_Reward_1_Content = {
    Text = "Recompensa pelo estilo de batalha"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_C_Create_Content = {
    Text = "Crie uma batalha"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_C_Joinin_Content = {
    Text = "Junte-se à batalha"
  },
  PanelText_UI_Pvp_Popup_Fight_Text_Title_Content = {
    Text = "Combate de senha"
  },
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Cancel_Content = {Text = "Cancelar"},
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Confirm_Content = {Text = "Confirmar"},
  PanelText_UI_Pvp_Popup_ImportTeam_Text_C_Title_Content = {
    Text = "Importar formação"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Placeholder_Content = {
    Text = "Digite 6 dígitos <color=#5EF2FF>valor da fase</color>"
  },
  PanelText_UI_Pvp_Popup_PasswordCode_Text_C_Cancel_Content = {Text = "Cancelar"},
  PanelText_UI_Pvp_Popup_PasswordCode_Text_C_Confirm_Content = {Text = "Confirmar"},
  PanelText_UI_Pvp_Popup_PasswordCode_Text_Title_Content = {
    Text = "Inserir valor de fase"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Cancel_Content = {Text = "Cancelar"},
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Copy_Content = {
    Text = "Copiar Valor de Fase"
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_C_Wait_Content = {
    Text = "Esperando..."
  },
  PanelText_UI_Pvp_Popup_PasswordMatch_Text_Title_Content = {
    Text = "Combate de senha"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Cancel_Content = {Text = "Cancelar"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Done_Content = {Text = "Me segue"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Mutual_Content = {
    Text = "Seguir mutuamente"
  },
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Ready_Content = {Text = "preparar"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Reject_Content = {Text = "Recusar"},
  PanelText_UI_Pvp_Popup_PasswordReady_Text_C_Wait_Content = {
    Text = "Esperando a outra parte se preparar..."
  },
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_C_Copy_Content = {Text = "Copiar"},
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Name_Content = {
    Text = "Assistir à gravação"
  },
  PanelText_UI_Pvp_Popup_PlaybackAngle_Text_Title_Content = {
    Text = "Escolha a perspectiva"
  },
  PanelText_UI_Pvp_Popup_Replacement_Text_C_Initial_Content = {
    Text = "Mão Inicial"
  },
  PanelText_UI_Pvp_Popup_Replacement_Text_C_Prompt_Content = {
    Text = "Clique para substituir cartas indesejadas"
  },
  PanelText_UI_Pvp_Popup_Reward_Tips_Text_C_Title_Content = {
    Text = "Recompensa de classificação"
  },
  PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Confirm_Content = {Text = "Confirmar"},
  PanelText_UI_Pvp_Popup_SelectCreation_Text_C_Title_Content = {
    Text = "Escolha 1 Relíquia"
  },
  PanelText_UI_Pvp_Popup_Settle_Text_C_Close_Content = {
    Text = "Clique no espaço em branco para continuar"
  },
  PanelText_UI_Pvp_Popup_Settle_Text_C_Succeed_Content = {
    Text = "Batalha vencida"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_Highest_Content = {
    Text = "Pontuação máxima histórica:"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Pvp_Popup_Tips2_Text_C_Title_Content = {
    Text = "Recorde de Xadrez"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity1_Content = {
    Text = "Recompensa de Ranking"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity2_Content = {
    Text = "Ranking da temporada"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity3_Content = {
    Text = "Ranking da temporada"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Activity4_Content = {
    Text = "Recompensa de Ranking"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Award_Content = {Text = "Recompensa"},
  PanelText_UI_Pvp_Popup_Tips_Text_C_Big_Content = {
    Text = "Informações do Guardião"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Game1_Content = {
    Text = "A classificação desta semana"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Game2_Content = {
    Text = "A classificação desta semana"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Grade_Content = {
    Text = "Classificação"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Hint_Content = {
    Text = "Ganhe uma partida nesta temporada para receber a recompensa de liquidação ao final da temporada."
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_NoTask_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_RankTip_Content = {
    Text = "Participe de uma partida nesta temporada para entrar no Ranking da Temporada."
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_Pvp_Content = {
    Text = "Selecionar tudo"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Rank_RotationMode_Content = {
    Text = "Escolha do draft"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Reward_Content = {
    Text = "Maior pontuação da temporada"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Scope_Content = {
    Text = "Intervalo de Classificação"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Small_Content = {
    Text = "Título de Xadrez"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_C_Title_2_Content = {
    Text = "Título de Xadrez"
  },
  PanelText_UI_Pvp_Popup_Tips_Text_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Fail_Content = {Text = "Falha"},
  PanelText_UI_Pvp_Popup_Victory_Text_C_Red_Content = {
    Text = "Clique para continuar"
  },
  PanelText_UI_Pvp_Popup_Victory_Text_C_Victory_Content = {Text = "Vitória"},
  PanelText_UI_Pvp_Popup_Victory_Text_C_Yellow_Content = {
    Text = "Clique para continuar"
  },
  PanelText_UI_Pvp_Popup_list_Tips_Text_C_Title_Content = {
    Text = "Tabela de Ranking"
  },
  PanelText_UI_Pvp_Popup_list_Tips_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Pvp_Team_Main_Text_C_Name_10_Content = {
    Text = "Equipar Roda do Destino"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_1_Content = {
    Text = "Ordem de Equipamento"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_2_Content = {
    Text = "4ª posição de despertar"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_3_Content = {
    Text = "3ª posição de despertar"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_4_Content = {
    Text = "Posição 2 Despertar"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_5_Content = {
    Text = "Despertar 1"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_6_Content = {
    Text = "Ordem de Equipamento"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_7_Content = {
    Text = "Equipar Roda do Destino"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_8_Content = {
    Text = "Equipar Roda do Destino"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_9_Content = {
    Text = "Equipar Roda do Destino"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Name_Content = {
    Text = "Formação rápida"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Realms_Content = {
    Text = "Domínio não ativado"
  },
  PanelText_UI_Pvp_Team_Main_Text_C_Title_Content = {
    Text = "Pré-grupo lineup"
  },
  PanelText_UI_Pvp_Team_Main_Text_Name_Content = {
    Text = "Formação rápida"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Copy_Content = {Text = "Copiar"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Done_Content = {Text = "Me segue"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Mutual_Content = {
    Text = "Seguir mutuamente"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Proficiency_Content = {
    Text = "Victórias cumulativas"
  },
  PanelText_UI_Pvp_Tip_Comment_Text_C_Remove_Content = {Text = "Editar"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Save_Content = {Text = "Excluir"},
  PanelText_UI_Pvp_Tip_Comment_Text_C_Title_Content = {
    Text = "Detalhes do Comentário"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Additional_Content = {
    Text = "Bônus extra"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_DiscountMultipleTitle_Content = {
    Text = "Super valor"
  },
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Haved_Content = {Text = "Possuído"},
  PanelText_UI_Recharge_Courtesy_Item_Text_C_Sellout_Content = {Text = "Esgotado"},
  PanelText_UI_Recharge_Exchange_Text_C_Buy_Title_Content = {
    Text = "Quantidade de Núcleo de Prata"
  },
  PanelText_UI_Recharge_Exchange_Text_C_Cost_Tips_Content = {Text = "Consumo"},
  PanelText_UI_Recharge_Exchange_Text_C_Least_Content = {Text = "Mínimo"},
  PanelText_UI_Recharge_Exchange_Text_C_Redeemed_Content = {
    Text = "Total trocado:"
  },
  PanelText_UI_Recharge_Exchange_Text_C_Utmost_Content = {Text = "Máximo"},
  PanelText_UI_Recharge_Exchange_Tips_Text_C_Not_Content = {
    Text = "Moeda insuficiente"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_Title_Content = {
    Text = "Confirmar troca"
  },
  PanelText_UI_Recharge_Exchange_Tips_Text_C_illustrate_Content = {
    Text = "Regras do Jogo"
  },
  PanelText_UI_Recharge_Instructions_Text_C_Title_Content = {Text = "Currículo"},
  PanelText_UI_Recharge_Instructions_Text_Name_Content = {Text = "Ir"},
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Cost_Tips_Content = {
    Text = "Consumo total"
  },
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Tips_Content = {
    Text = "Pode remover itens desnecessários"
  },
  PanelText_UI_Recharge_OnekeyPurchase_Text_C_Title_Content = {
    Text = "Confirmação de compra"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Buttom_Content = {
    Text = "Primeira compra de cada nível concede a mesma quantidade de \"Líquido de Origem de Núcleo de Prata\" bônus, apenas uma vez"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Law1_Content = {
    Text = "Lei do Comércio Especial"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Law2_Content = {
    Text = "Método de Liquidação de Fundos"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Refresh_Content = {
    Text = "Suporte ao cliente"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_C_Title_Content = {
    Text = "Extração de líquido fonte"
  },
  PanelText_UI_Recharge_Panel_Extract_Text_PayTip_Content = {
    Text = "O preço exibido atualmente é o preço padrão da moeda, apenas para referência. Na hora do pagamento, prevalecerá a moeda e o preço reais."
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_Desc_Content = {
    Text = "Descrição do evento"
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_Slogan_Content = {
    Text = [[
Apenas 24 horas! 
Escolha um Despertado permanente!]]
  },
  PanelText_UI_Recharge_Panel_GiftBag_Text_C_SpecialTime_Content = {Text = "Restante"},
  PanelText_UI_Recharge_Panel_GiftBag_Text_PayTip_Content = {
    Text = "O preço exibido atualmente é o preço padrão da moeda, apenas para referência. Na hora do pagamento, prevalecerá a moeda e o preço reais."
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Bigitle_Content = {
    Text = "Observação das fases da lua"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Buttom_Tips_Content = {
    Text = "Primeira recarga de cada pacote dobra, apenas uma vez"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Cost_Tips_Content = {Text = "Consumo"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Expired_Content = {Text = "Expirado"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Flushed_Content = {Text = "Atualizar"},
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get1_Title_Content = {
    Text = "Receba imediatamente"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Get2_Title_Content = {
    Text = "Presente diário"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Illustrate_Content = {
    Text = "Pode ser acumulado"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_OnekeyPurchase_Content = {
    Text = "Comprar com um clique"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Refresh_Content = {
    Text = "Suporte ao cliente"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Tips_Content = {
    Text = "*Acumule 300 Cristais de Núcleo de Prata + 3000 Núcleos de Prata"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_C_Today_Content = {
    Text = "Recebido hoje"
  },
  PanelText_UI_Recharge_Panel_Main_Optimized_Text_Get2_Title2_Content = {
    Text = "（30 dias）"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Bigitle_Content = {
    Text = "Observação das fases da lua"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Bigtitle_Content = {
    Text = "Observação das fases da lua"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Buttom_Tips_Content = {
    Text = "Para cada primeira compra por faixa, receba Prata bônus equivalente ao valor da recarga. (Oferta única por faixa)"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Buy_Content = {Text = "Comprar"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Cost_Tips_Content = {Text = "Consumo"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Double_Content = {Text = "Extra"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Expired_Content = {Text = "Expirado"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Extra_Content = {Text = "Extra"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Flushed_Content = {Text = "Atualizar"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Get1_NumName_Content = {
    Text = "Líquido de origem"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get1_Title_Content = {
    Text = "Receba imediatamente"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_NumName_Content = {
    Text = "Núcleo de prata"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Title2_Content = {
    Text = "（30 dias）"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Get2_Title_Content = {
    Text = "Presente diário"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Illustrate_Content = {
    Text = "Pode ser acumulado"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_OnekeyPurchase_Content = {
    Text = "Comprar com um clique"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Refresh_Content = {
    Text = "Suporte ao cliente"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip1_Content = {
    Text = "Login diário acumulado concede\nPrata <color=#57F8FE><size=38>×6000</size></color>!"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_RewardTip2_Content = {
    Text = "Login diário acumulado concede\n<color=#57F8FE><size=38>6000</size></color> Lingfétide e<color=#57F8FE><size=38>600</size></color> Pluma de lembrança!"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Get1_Title_Content = {
    Text = "Receba imediatamente"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Illustrate_Content = {
    Text = "Regras do Jogo"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Need_Content = {
    Text = "Necessário"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Tips_Content = {
    Text = "Presente diário por e-mail (30 dias)"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Stamina_Title_Content = {
    Text = "Ravitalemento no coldre"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Tips_Content = {
    Text = "*300 + 6000 Núcleos de Prata no total!"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Title_Content = {
    Text = "Loja de Misaka"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Today_Content = {
    Text = "Recebido hoje"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Month_Content = {
    Text = "Observação das fases da lua"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Recharge_Content = {Text = "Recarga"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Normal_Root_Content = {
    Text = "Espuma da Origem"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Month_Content = {
    Text = "Observação das fases da lua"
  },
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Recharge_Content = {Text = "Recarga"},
  PanelText_UI_Recharge_Panel_Main_Text_C_Toggle_Select_Root_Content = {
    Text = "Espuma da Origem"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Get2_Title2_Content = {
    Text = "（30 dias）"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Name_Content = {Text = "Comprar"},
  PanelText_UI_Recharge_Panel_Main_Text_Tips_Content = {
    Text = "*300 + 6000 Núcleos de Prata no total!"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Month_Content = {
    Text = "Observação das fases da lua"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Recharge_Content = {Text = "Recarga"},
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Normal_Root_Content = {
    Text = "Espuma da Origem"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Month_Content = {
    Text = "Observação das fases da lua"
  },
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Recharge_Content = {Text = "Recarga"},
  PanelText_UI_Recharge_Panel_Main_Text_Toggle_Select_Root_Content = {
    Text = "Espuma da Origem"
  },
  PanelText_UI_Recharge_Panel_Month_Tips_Text_C_Today_Content = {
    Text = "Clique para receber recompensas de observação da fase lunar"
  },
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Disable_Content = {Text = "Comprar"},
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Normal_Content = {Text = "Comprar"},
  PanelText_UI_Recharge_Panel_OptionGift_Text_C_Title_Content = {
    Text = "Loja de Misaka"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Cancel_Content = {Text = "Cancelar"},
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Confirm_Content = {Text = "Comprar"},
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Cost_Tips_Content = {Text = "Consumo"},
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Title_Content = {
    Text = "Confirmação de compra"
  },
  PanelText_UI_Recharge_Popup_OptionGift_Text_C_Title_En_Content = {Text = "Title"},
  PanelText_UI_Recharge_Reset_Item_Text_C_Double_Content = {
    Text = "Primeira Recarga"
  },
  PanelText_UI_Recharge_Reset_Item_Text_C_Extra_Content = {Text = "Extra"},
  PanelText_UI_Research_Panel_Ceri_Item_Text_C_Activate_Content = {Text = "Ativado"},
  PanelText_UI_Research_Panel_Ceri_Item_Text_C_NoeGet_Content = {
    Text = "Não obteve o Desperto"
  },
  PanelText_UI_Research_Panel_Ceri_Item_Text_Name_Content = {
    Text = "Ativar talento"
  },
  PanelText_UI_Research_Panel_Ceri_Text_C_Activate_Content = {Text = "Ativado"},
  PanelText_UI_Research_Panel_Ceri_Text_C_Title_Content = {
    Text = "Visão geral do talento"
  },
  PanelText_UI_Research_Panel_Challenge_Item_Text_C_Undone_Content = {Text = "Incompleto"},
  PanelText_UI_Research_Panel_Challenge_Text_C_PlanName_Content = {
    Text = "Progresso atual"
  },
  PanelText_UI_Research_Panel_Challenge_Text_C_ReachName_Content = {
    Text = "Todas as conquistas alcançadas"
  },
  PanelText_UI_Research_Panel_Challenge_Text_Title_Content = {Text = "Conquistas"},
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Award_Content = {
    Text = "Recompensa da missão"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Count_Content = {Text = "Regras"},
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Extra_Content = {Text = "[Extra]"},
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_NoTask_Content = {
    Text = "Nenhuma nova tarefa de despacho no momento"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special2_Content = {
    Text = "Para cada 20 níveis adicionais no Nível Total de Despacho, você receberá 1 recompensa extra"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_C_Special_Content = {
    Text = "Condições de Conquista"
  },
  PanelText_UI_Research_Panel_Dispatch_Content_Text_Underway_Content = {
    Text = "Despachando"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Tip_Content = {Text = "A receber"},
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Unclickable_Content = {
    Text = "Não desbloqueado"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_C_Underway_Content = {
    Text = "Em andamento"
  },
  PanelText_UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Content = {Text = "Restante"},
  PanelText_UI_Research_Panel_Dispatch_Item_Text_Tine_Title_Normal_Content = {Text = "Consumo"},
  PanelText_UI_Research_Panel_Dispatch_Text_Title_Content = {Text = "Envio"},
  PanelText_UI_Research_Popup_Dispatch_Text_Title_Content = {
    Text = "Resumo das Bênçãos de Despacho"
  },
  PanelText_UI_Research_Popup_Recall2_Text_Agin_Content = {
    Text = "Novamente enviando"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Dispatch_Content = {
    Text = "Despertar no despacho"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Reward_Content = {
    Text = "Recompensa da missão"
  },
  PanelText_UI_Research_Popup_Recall2_Text_C_Title_Content = {
    Text = "Relatório de despacho"
  },
  PanelText_UI_Research_Popup_Recall2_Text_Close_Content = {Text = "Fechar"},
  PanelText_UI_Research_Popup_Recall_Text_C_Award_Content = {
    Text = "Recompensa da missão"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Dispatch_Content = {
    Text = "Nível total atual"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Extra_Content = {Text = "[Extra]"},
  PanelText_UI_Research_Popup_Recall_Text_C_Level_Content = {
    Text = "A missão foi enviada com nível total"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Special2_Content = {
    Text = "Para cada 20 níveis adicionais no Nível Total de Despacho, você receberá 1 recompensa extra"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Special_Content = {
    Text = "Condições de Conquista"
  },
  PanelText_UI_Research_Popup_Recall_Text_C_Title_Content = {
    Text = "Escolha o despertador para tarefas"
  },
  PanelText_UI_Research_Popup_Report_Text_C_Title_Content = {
    Text = "Relatório de Investigação"
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_C_Tip_Content = {
    Text = "Você pode selecionar novamente em \"Configurações - Idioma\" posteriormente"
  },
  PanelText_UI_Setting_Popup_ChooseLang_Text_Name_Content = {Text = "Confirmar"},
  PanelText_UI_Setting_Popup_ChooseLang_Text_Title_Content = {
    Text = "Escolher idioma"
  },
  PanelText_UI_Setting_Popup_Code_Text_C_Clean_Content = {Text = "Eliminar"},
  PanelText_UI_Setting_Popup_Code_Text_C_Paste_Content = {Text = "Colar"},
  PanelText_UI_Setting_Popup_Code_Text_C_Tips_Content = {
    Text = "Digite código de resgate"
  },
  PanelText_UI_Setting_Popup_Down_Text_C_Downing_Content = {
    Text = "Baixando recursos"
  },
  PanelText_UI_Setting_Popup_Examine_Text_C_Examine_Content = {
    Text = "Verificando integridade dos recursos do jogo"
  },
  PanelText_UI_Setting_Popup_Main_Text_C_Tips_Content = {Text = "GM interno"},
  PanelText_UI_Setting_Popup_Main_Text_C_Title_Content = {
    Text = "Configurações"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_1_Content = {Text = "Receber"},
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Receive_2_Content = {Text = "Receber"},
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_Title_Content = {
    Text = "Recompensa de Login"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_1_Content = {
    Text = "Não alcançado"
  },
  PanelText_UI_Setting_Popup_PlatformBinding_Text_C_UnDone_2_Content = {
    Text = "Não alcançado"
  },
  PanelText_UI_Shop_Item_Commodity_Text_C_Head_Content = {Text = "Avatar"},
  PanelText_UI_Shop_Item_Commodity_Text_C_Value_Content = {
    Text = "Super valor"
  },
  PanelText_UI_Shop_Item_Toggle_Text_C_Recommend_Content = {Text = "Recomendar"},
  PanelText_UI_Shop_Popup_Tips_Text_C_Tips_Content = {
    Text = "Moeda insuficiente"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Assist_Content = {
    Text = "Número de apoios de batalha"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Awaker_Content = {
    Text = "Conexão com o despertador"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Birthday_Content = {
    Text = "Aniversário"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Concern2_Content = {Text = "Seguir"},
  PanelText_UI_Social_Item_Data_Left_Text_C_Conclude_Content = {
    Text = "Conquistar Realização"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Difficulty_Content = {
    Text = "Operação de investigação"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Dream_Content = {
    Text = "Mergulho Fantasmal"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Fans_Content = {Text = "Seguidor"},
  PanelText_UI_Social_Item_Data_Left_Text_C_Highest_Content = {
    Text = "Recorde máximo"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Indestructible_Content = {
    Text = "Reino sombrio·fissura de rotação"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Pagoda_Content = {
    Text = "Reino sem luz"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Privacy_Content = {
    Text = "O Guardião definiu o status da investigação como privado"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Register_Content = {
    Text = "Dias de login"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Society_Content = {
    Text = "Guilda pertencente"
  },
  PanelText_UI_Social_Item_Data_Left_Text_C_Survey_Content = {
    Text = "Status da Investigação"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Placeholder_Content = {
    Text = "Insira uma biografia"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Abyss_Content = {
    Text = "Zona Proibida de Catástrofe de Fusão"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Assist_Content = {
    Text = "Número de apoios de batalha"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Attention_Content = {Text = "Seguir"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Awaker_Content = {
    Text = "Conexão com o despertador"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Ban_Content = {Text = "Bloquear"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Birthday_Content = {
    Text = "Aniversário"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Collection_Content = {
    Text = "Progresso da Coleção"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Concern2_Content = {Text = "Seguir"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Conclude_Content = {
    Text = "Conquistar Realização"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Difficulty_Content = {
    Text = "Operação de investigação"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Dream_Content = {
    Text = "Mergulho Fantasmal"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Fans_Content = {Text = "Seguidor"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Gender_Content = {Text = "Gênero"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Hard_Content = {
    Text = "Dificuldade"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Highest_Content = {
    Text = "Recorde máximo"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Indestructible_Content = {
    Text = "Reino sombrio·fissura de rotação"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Interrelated_Content = {
    Text = "Seguir mutuamente"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Normal_Content = {Text = "Comum"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Notset_Content = {
    Text = "Não configurado"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Pagoda_Content = {
    Text = "Reino sem luz"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Privacy_Content = {
    Text = "O Guardião definiu o status da investigação como privado"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Register_Content = {
    Text = "Dias de login"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Society_Content = {
    Text = "Guilda pertencente"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Survey_Content = {
    Text = "Status da Investigação"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_1_Content = {Text = "Total"},
  PanelText_UI_Social_Item_Data_Overview_Left_Text_C_Total_2_Content = {
    Text = "Recorde máximo"
  },
  PanelText_UI_Social_Item_Data_Overview_Left_Text_NickNamePre_Content = {Text = "Nota:"},
  PanelText_UI_Social_Item_Data_Right_Text_C_Help_Content = {
    Text = "Despertar de apoio de batalha"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Not_Content = {
    Text = "Sem Desperto de suporte configurado"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Null_1_Content = {
    Text = "Forma de despertar não exibida"
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Squiggle_Content = {
    Text = "A prata gera conhecimento."
  },
  PanelText_UI_Social_Item_Data_Right_Text_C_Team_Content = {
    Text = "Exibição do Despertado"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Accept_Content = {Text = "Aceitar"},
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Cancel_Content = {Text = "Cancelado"},
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Done_Content = {Text = "Me segue"},
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Mutual_Content = {
    Text = "Seguir mutuamente"
  },
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse2_Content = {Text = "Recusado"},
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Refuse_Content = {Text = "Recusar"},
  PanelText_UI_Social_Item_FriendlyInvite_Text_C_Timeout_Content = {
    Text = "Tempo esgotado"
  },
  PanelText_UI_Social_Item_PveRecord_Text_Fail_Content = {Text = "Falha"},
  PanelText_UI_Social_Item_PveRecord_Text_Victory_Content = {Text = "Vitória"},
  PanelText_UI_Social_Item_PvpData_Text_C_Point_01_Content = {Text = "Minuto"},
  PanelText_UI_Social_Item_PvpData_Text_Fail_Content = {Text = "Falha"},
  PanelText_UI_Social_Item_PvpData_Text_Victory_Content = {Text = "Vitória"},
  PanelText_UI_Social_Item_PvpRecord_Text_Fail_Content = {Text = "Falha"},
  PanelText_UI_Social_Item_PvpRecord_Text_Victory_Content = {Text = "Vitória"},
  PanelText_UI_Social_Item_Pvp_Text_C_Dispaly_Content = {
    Text = "Liberar registro de combate"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Input_Content = {
    Text = "Digite \"Registro de combate\" para ver a gravação"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_NoTask_Content = {
    Text = "Nenhum registro de traphase disponível"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pve_Nor_Content = {
    Text = "Operação de investigação"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pve_Sel_Content = {
    Text = "Operação de investigação"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Nor_Content = {
    Text = "Fase de Duelo"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Pvp_Sel_Content = {
    Text = "Fase de Duelo"
  },
  PanelText_UI_Social_Item_Pvp_Text_C_Search_Content = {
    Text = "Assistir à gravação"
  },
  PanelText_UI_Social_Item_Pvp_Text_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Social_Item_Rank_Text_C_Attention_Content = {Text = "Seguir"},
  PanelText_UI_Social_Item_Rank_Text_C_Following_Content = {Text = "Seguindo"},
  PanelText_UI_Social_Item_Rank_Text_C_Interrelated_Content = {Text = "Seguindo"},
  PanelText_UI_Social_Panel_Data_Text_C_Assist_Content = {
    Text = "Número de apoios de batalha"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Awaker_Content = {
    Text = "Conexão com o despertador"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Birthday_Content = {
    Text = "Aniversário"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Concern2_Content = {Text = "Seguir"},
  PanelText_UI_Social_Panel_Data_Text_C_Conclude_Content = {
    Text = "Conquistar Realização"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Difficulty_Content = {
    Text = "Dificuldade"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Dream_Content = {
    Text = "Mergulho Fantasmal"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Fans_Content = {Text = "Seguidor"},
  PanelText_UI_Social_Panel_Data_Text_C_Help_Content = {
    Text = "Despertar de apoio de batalha"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Indestructible_Content = {
    Text = "Inominável"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Not_Content = {
    Text = "Sem Desperto de suporte configurado"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Null_1_Content = {
    Text = "Forma de despertar não exibida"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Pagoda_Content = {
    Text = "Torre Sem Luz"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Privacy_Content = {
    Text = "O Guardião definiu o status da investigação como privado"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Register_Content = {
    Text = "Dias de login"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Society_Content = {
    Text = "Guilda pertencente"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Squiggle_Content = {
    Text = "A prata gera conhecimento."
  },
  PanelText_UI_Social_Panel_Data_Text_C_Survey_Content = {
    Text = "Status da Investigação"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Team_Content = {
    Text = "Exibição do Despertado"
  },
  PanelText_UI_Social_Panel_Data_Text_C_Title_Content = {
    Text = "Arquivo do Guardião"
  },
  PanelText_UI_Social_Panel_HelpList_Filter_Text_C_Selected_Content = {
    Text = "Selecionado"
  },
  ["PanelText_UI_Social_Panel_HelpList_Item_Text_C_ Interrelated_Content"] = {
    Text = "Seguir mutuamente"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Attention_Content = {Text = "Seguir"},
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Commonly_Content = {
    Text = "Apoio de batalha comum"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Conflict_Content = {
    Text = "Conflito de domínio"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Fans_Content = {Text = "Seguidor"},
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Following_Content = {Text = "Seguindo"},
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recent_Content = {
    Text = "Assistência recente"
  },
  PanelText_UI_Social_Panel_HelpList_Item_Text_C_Recommend_Content = {
    Text = "Recomendar seguir"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_CommonlyAssist_Content = {
    Text = "Apoio de batalha comum"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Dis_1_Content = {Text = "Atualizar"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Dis_Content = {Text = "Entrar"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Nor_1_Content = {Text = "Atualizar"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Confim_Nor_Content = {Text = "Entrar"},
  PanelText_UI_Social_Panel_HelpList_Text_C_Mail_Content = {Text = "Regras"},
  PanelText_UI_Social_Panel_HelpList_Text_C_NoTask_Content = {
    Text = "Nenhum Despertador compatível encontrado, recomenda-se ajustar \"filtro Despertador\""
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Time_Content = {
    Text = "Pode usar Despertados de apoio de batalha de Guardiões do Segredo que seguem você mutuamente"
  },
  PanelText_UI_Social_Panel_HelpList_Text_C_Title_Content = {
    Text = "Escolha suporte"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Attention_Content = {Text = "Seguir"},
  PanelText_UI_Social_Panel_Main_Item_Text_C_Done_Content = {Text = "Me segue"},
  PanelText_UI_Social_Panel_Main_Item_Text_C_Following_Content = {Text = "Seguindo"},
  PanelText_UI_Social_Panel_Main_Item_Text_C_Interrelated_Content = {
    Text = "Seguir mutuamente"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Mutual_Content = {
    Text = "Seguir mutuamente"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_C_Unblock_Content = {
    Text = "Desbloquear"
  },
  PanelText_UI_Social_Panel_Main_Item_Text_Unfollow_Content = {
    Text = "Deixar de seguir"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_Concern_Content = {Text = "Adicionado"},
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_NoTask_Content = {
    Text = "Sem seguir ninguém"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_1_Text_C_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_C_NoTask_Content = {
    Text = "Sem buscas relacionadas"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_C_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Social_Panel_Main_SubPanel_2_Text_Name_Content = {
    Text = "Seguir tudo"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Concern_Content = {Text = "Adicionado"},
  PanelText_UI_Social_Panel_Main_Text_C_NoTask_Content = {
    Text = "Sem seguidores"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Stranger_Content = {Text = "Estranho"},
  PanelText_UI_Social_Panel_Main_Text_C_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Tips_1_Content = {
    Text = "Digite nome para buscar"
  },
  PanelText_UI_Social_Panel_Main_Text_C_Tips_2_Content = {
    Text = "Digite nome para buscar"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_Interaction_Content = {
    Text = "Interação"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_NoTask_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_PlayerInfo_Content = {
    Text = "Especialista"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_Rank_Content = {
    Text = "Classificação"
  },
  PanelText_UI_Social_Panel_RankList_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Social_Panel_Rank_Text_C_All_Content = {Text = "Tudo"},
  PanelText_UI_Social_Panel_Rank_Text_C_Friend_Content = {Text = "Seguir"},
  PanelText_UI_Social_Panel_Rank_Text_C_Interaction_Content = {
    Text = "Interação"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_NoTask_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_PlayerInfo_Content = {
    Text = "Informações do Guardião"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_Rank_Content = {
    Text = "Classificação"
  },
  PanelText_UI_Social_Panel_Rank_Text_C_Sign_Content = {Text = "Resumo"},
  PanelText_UI_Social_Panel_Rank_Text_C_Uid_Title_Content = {Text = "UID:"},
  PanelText_UI_Social_Popup_Awaker_Text_C_Owned_Content = {Text = "Possuído"},
  PanelText_UI_Social_Popup_Birthday_Text_C_Day_Content = {Text = "Dia"},
  PanelText_UI_Social_Popup_Birthday_Text_C_Month_Content = {Text = "Lua"},
  PanelText_UI_Social_Popup_Birthday_Text_C_Title_Content = {
    Text = "Editar Aniversário"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_NoTask_Content = {
    Text = "Sem aliados de batalha"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_SearchTip_Content = {
    Text = "Digite UID para encontrar Guardião do Segredo"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_Search_Content = {Text = "Procurar"},
  PanelText_UI_Social_Popup_CommonlyAssist_Text_C_Title_Content = {
    Text = "Apoio de batalha comum"
  },
  PanelText_UI_Social_Popup_CommonlyAssist_Text_Time_Content = {
    Text = "Vá ver outros lugares"
  },
  PanelText_UI_Social_Popup_FriendlyInvite_Text_Title_Content = {
    Text = "Convite para partida amistosa"
  },
  PanelText_UI_Social_Popup_Introduction_Text_C_Placeholder_Content = {
    Text = "Insira uma biografia"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Content = {Text = "Escolher"},
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Desc_Content = {
    Text = "<size=25>O modo básico de traphase, ambos os lados usam equipes preparadas para a batalha.</size>"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_FriendlyMatch_Name_Content = {
    Text = "Modo de Pré-equipe"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Content = {Text = "Escolher"},
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Desc_Content = {
    Text = "<size=25>O modo avançado de traphase, ambos os lados alternam escolhas de cartas de um pool aleatório para formar baralhos para a batalha.</size>"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_C_RotationMode_Name_Content = {
    Text = "Modo de seleção de roda"
  },
  PanelText_UI_Social_Popup_MatchMode_Text_Title_Content = {
    Text = "Escolher modo"
  },
  PanelText_UI_Social_Popup_Match_Text_C_Waiting_Content = {Text = "Aguardando"},
  PanelText_UI_Social_Popup_Match_Text_Name_Content = {Text = "Cancelar"},
  PanelText_UI_Social_Popup_Match_Text_Title_Content = {
    Text = "Partida amistosa"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Content = {
    Text = "Moldura do avatar"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_HeadFrame_Sel_Content = {
    Text = "Moldura do avatar"
  },
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Content = {Text = "Avatar"},
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Head_Sel_Content = {Text = "Avatar"},
  PanelText_UI_Social_Popup_PlayerHead_Text_C_Using_Content = {Text = "Em uso"},
  PanelText_UI_Social_Popup_Situation_Tips_Text_C_AffixInfo_Content = {
    Text = "Status da Investigação"
  },
  PanelText_UI_Social_Popup_SwitchGender_Text_C_Cost_Content = {Text = "Consumo"},
  PanelText_UI_Social_Popup_SwitchGender_Text_Cancel_Name_Content = {Text = "Cancelar"},
  PanelText_UI_Social_Popup_SwitchGender_Text_Confirm_Name_Content = {Text = "Confirmar"},
  PanelText_UI_Social_Popup_SwitchGender_Text_Title_Content = {
    Text = "Mudar gênero"
  },
  PanelText_UI_Social_Popup_WatchList_Text_C_NoTask_Content = {
    Text = "Sem novos seguidores"
  },
  PanelText_UI_Social_Popup_WatchList_Text_Name_FollowAll_Content = {
    Text = "Seguir tudo"
  },
  PanelText_UI_Social_Popup_WatchList_Text_Tip_Content = {
    Text = "Você pode ver os 100 novos seguidores recentes"
  },
  PanelText_UI_Social_Tips_InviteBubble_Text_Name_Content = {
    Text = "Partida amistosa"
  },
  PanelText_UI_Story_Panel_Main_Text_C_High_Content = {
    Text = "Redefinir Fundo de Login"
  },
  PanelText_UI_Story_Panel_Main_Text_C_Normal_Content = {
    Text = "Definir como Fundo de Login"
  },
  PanelText_UI_Story_Popup_Curtain_Call_Text_C_Continue_Content = {
    Text = "Continue a jornada"
  },
  PanelText_UI_Story_Popup_Curtain_Call_Text_C_Title_Content = {
    Text = "Memória Arquivada"
  },
  PanelText_UI_Story_Portrait_Test_Text_C_Close_Content = {Text = "Fechar"},
  PanelText_UI_Story_Portrait_Test_Text_C_Hide_Content = {Text = "Esconder"},
  PanelText_UI_Summon_Btn_Jump_Text_C_Look_Content = {Text = "Ver"},
  PanelText_UI_Summon_Btn_Realms_Text_C_Difficulty_Content = {
    Text = "Dificuldade inicial"
  },
  PanelText_UI_Summon_Btn_Realms_Text_C_Directional_Content = {
    Text = "Direção atual"
  },
  PanelText_UI_Summon_Btn_Realms_Text_C_Name_Content = {Text = "Escolha"},
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Full_Content = {
    Text = "Iluminar Completo"
  },
  PanelText_UI_Summon_Item_OptionalLimit_Text_C_Have_Content = {Text = "Possuído"},
  PanelText_UI_Summon_Item_Probability_Text_C_Name_Content = {
    Text = "Denominação"
  },
  PanelText_UI_Summon_Item_Probability_Text_C_Role_Content = {
    Text = "Probabilidade combinada"
  },
  PanelText_UI_Summon_Item_Probability_Text_C_Time_Content = {
    Text = "Denominação"
  },
  PanelText_UI_Summon_Item_Probability_Text_C_Type_Content = {Text = "Tipo"},
  PanelText_UI_Summon_Item_Probability_Text_Limit_Content = {Text = "limitado"},
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_GiftTitle_Content = {
    Text = "Concluir missão para receber o voucher de troca de Roupa Fantasma"
  },
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_1_Content = {
    Text = "Deve obtê-los ambos"
  },
  PanelText_UI_Summon_Panel_LuckyBag_Text_C_LuckyBag_2_Content = {
    Text = "Deve obtê-los os três"
  },
  PanelText_UI_Summon_Panel_Main_Text_Award_Content = {
    Text = "Recompensa extra"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Choose_Content = {
    Text = "Iniciar seleção"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Difficult_Title_Content = {
    Text = "Dificuldade inicial"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_FirstLimit_Content = {
    Text = "Primeira edição limitada"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_FreeLimit_Content = {Text = "Grátis"},
  PanelText_UI_Summon_Panel_Main_Text_C_Hint_Content = {
    Text = "Mas clique aqui para mudar de domínio"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_LimitName_Content = {
    Text = "Despertar cinco vezes"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Limited_Content = {
    Text = "Limited Time Role"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Look_Content = {Text = "Ver"},
  PanelText_UI_Summon_Panel_Main_Text_C_Name_Content = {Text = "Permanente"},
  PanelText_UI_Summon_Panel_Main_Text_C_Realms_Content = {
    Text = "Escolher domínio"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_RecAwaker_Content = {
    Text = "Despertado Recomendado"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_School_Intro_Title_Content = {
    Text = "Característica de Domínio——"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_Summon_Content = {
    Text = "Despertar 5 vezes"
  },
  PanelText_UI_Summon_Panel_Main_Text_C_System_Name_Content = {Text = "Despertar"},
  PanelText_UI_Summon_Panel_Main_Text_C_TryName_Content = {
    Text = "Teste dos Despertos"
  },
  PanelText_UI_Summon_Panel_Main_Text_Desc_2_Content = {
    Text = "Descrição"
  },
  PanelText_UI_Summon_Panel_Main_Text_FreeTen_Content = {Text = "Grátis"},
  PanelText_UI_Summon_Panel_Main_Text_Recommend_Content = {
    Text = "Recomendação de Despertar para Novo Nascido"
  },
  PanelText_UI_Summon_Panel_SelectLimit_Text_C_Choose_Content = {
    Text = "Iniciar seleção"
  },
  PanelText_UI_Summon_Panel_SelectLimit_Text_C_Title_Content = {
    Text = "Corpo Desperto designado"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Detail_Content = {Text = "Regras"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Inventory_Content = {
    Text = "Lista de itens"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Name_Content = {
    Text = "Denominação"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Not_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Prompt_Content = {
    Text = "Consultar registros de despertar dos últimos 6 meses nesta página, com possível atraso de cerca de 1 hora"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_REcording_Content = {
    Text = "Registros históricos"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Role_Content = {
    Text = "Tipo de despertar"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Time_Content = {
    Text = "Hora de despertar"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_1_Content = {
    Text = "Tipo de despertar"
  },
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Type_Content = {Text = "Tipo"},
  PanelText_UI_Summon_Popup_Detail_Tip_Text_C_Up_Content = {Text = "Itens UP"},
  PanelText_UI_Summon_Popup_Main_Text_C_Name_Content = {
    Text = "Denominação"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Not_Content = {
    Text = "Sem registros"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Prompt_Content = {
    Text = "Consultar registros de despertar dos últimos 6 meses nesta página, com possível atraso de cerca de 1 hora"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Role_Content = {
    Text = "Tipo de despertar"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Time_Content = {
    Text = "Hora de despertar"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Title_Content = {
    Text = "Registros de despertar"
  },
  PanelText_UI_Summon_Popup_Main_Text_C_Type_Content = {Text = "Tipo"},
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Change_Content = {
    Text = "Selecionar Novamente"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_ChooseTitle_Content = {
    Text = "Escolha despertar"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_Choose_Content = {
    Text = "Iniciar seleção"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_C_InfoTitle_Content = {
    Text = "Descrição do Jogo"
  },
  PanelText_UI_Summon_Popup_MixPoolLimit_Text_Title_Content = {
    Text = "Escolha despertar"
  },
  PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Confirm_Content = {
    Text = "Confirmar Seleção"
  },
  PanelText_UI_Summon_Popup_OptionalLimit_Text_C_Tip_Content = {
    Text = "Pressione e segure o Corpo Desperto para ver os detalhes"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Confirm_Content = {
    Text = "Confirmar Seleção"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Tip_Content = {
    Text = "Pressione e segure o Corpo Desperto para ver os detalhes"
  },
  PanelText_UI_Summon_Popup_OptionalMixPoolLimit_Text_C_Title_Content = {
    Text = "Escolha despertar"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Activity_Content = {
    Text = "Presente da roda do destino"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Game_Content = {
    Text = "Presente dos Despertos"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Info_Content = {
    Text = "Após 150 [Estudo do Reino] despertamentos, ganhe um dos Despertadores acima/Roda do Destino."
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_C_Plan_Content = {Text = "Progresso"},
  PanelText_UI_Summon_Popup_Presented_Tip_Text_Check_Content = {
    Text = "Ver detalhes"
  },
  PanelText_UI_Summon_Popup_Presented_Tip_Text_Git_Content = {Text = "Receber"},
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Detail_Content = {
    Text = "Descrição detalhada"
  },
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Inventory_Content = {
    Text = "Lista de itens"
  },
  PanelText_UI_Summon_Popup_Prob_Tip_Text_C_Up_Content = {Text = "Itens UP"},
  PanelText_UI_Summon_Popup_Realms_Text_C_Introduce_Content = {
    Text = "Escolha domínio, personagem despertado será deste domínio, pode mudar depois"
  },
  PanelText_UI_Summon_Popup_Realms_Text_C_Title_Content = {
    Text = "Domínio designado"
  },
  PanelText_UI_Summon_Popup_Recording_Text_C_Prompt_Content = {
    Text = "Consultar registros de despertar dos últimos 6 meses nesta página, com possível atraso de cerca de 1 hora"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_ChooseTitle_Content = {
    Text = "Escolha despertar"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_Choose_Content = {
    Text = "Iniciar seleção"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_C_InfoTitle_Content = {
    Text = "Descrição do Jogo"
  },
  PanelText_UI_Summon_Popup_SelectLimit_Text_Title_Content = {
    Text = "Escolha despertar"
  },
  PanelText_UI_Summon_Popup_Share_Text_C_Share_Content = {
    Text = "Compartilhar em:"
  },
  PanelText_UI_Summon_Popup_Show_Legend_Text_Autofine_Content = {
    Text = "Empilhamento automático"
  },
  PanelText_UI_Summon_Popup_Show_Legend_Text_C_Name_Content = {
    Text = "Despertar uma vez"
  },
  PanelText_UI_Summon_Popup_Show_Ordinary_Text_Autofine_Content = {
    Text = "Empilhamento automático"
  },
  PanelText_UI_Summon_Popup_Show_Ordinary_Text_C_Name_Content = {
    Text = "Despertar uma vez"
  },
  PanelText_UI_Summon_Popup_Show_Rare_Text_Autofine_Content = {
    Text = "Empilhamento automático"
  },
  PanelText_UI_Summon_Popup_Show_Rare_Text_C_Name_Content = {
    Text = "Despertar uma vez"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_C_Share_Content = {
    Text = "Primeira vez compartilhando"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_Confirm_Name_Content = {Text = "Confirmar"},
  PanelText_UI_Summon_Popup_Total_Show_Text_Name_Content = {Text = "Reacordar"},
  PanelText_UI_Summon_Popup_Total_Show_Text_ReSummon_Content = {
    Text = "Despertar 5 vezes"
  },
  PanelText_UI_Summon_Popup_Total_Show_Text_Toggle_Content = {
    Text = "Despertar rápido"
  },
  PanelText_UI_Summon_Result_Panel_Text_C_Name_Content = {
    Text = "Despertar uma vez"
  },
  PanelText_UI_Summon_Result_Panel_Text_C_Share_Content = {
    Text = "Primeira vez compartilhando"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Auto_Content = {
    Text = "Obter roda do destino recomendada automaticamente"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_ChooseTitle_Content = {
    Text = "Escolha despertar"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Choose_Content = {
    Text = "Escolha despertar"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_Confirm_Content = {
    Text = "Confirmar seleção"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_C_InfoTitle_Content = {
    Text = "Descrição do Jogo"
  },
  PanelText_UI_Suummoon_Popup_AwakerWeapon_Text_Title_Content = {
    Text = "Escolha despertar"
  },
  PanelText_UI_Task_Item_Detail_List_New_Text_C_Get_Content = {Text = "Receber"},
  PanelText_UI_Task_Panel_Main_New_Text_C_Achievement_Content = {
    Text = "Conquistas de Carreira"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_ActionReports_Content = {
    Text = "Relatório de missão"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_GrowUp_Content = {
    Text = "Registro de Crescimento"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Master_Content = {
    Text = "Domínio de área"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Tips2_Content = {
    Text = "Lista de Tarefas Vazia"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Tips_Content = {
    Text = "Missão diária concluída"
  },
  PanelText_UI_Task_Panel_Main_New_Text_C_Title_Content = {
    Text = "Sem missões no momento"
  },
  PanelText_UI_Task_Popup_Career_Item_Text_C_Undone_Content = {Text = "Incompleto"},
  PanelText_UI_Task_Popup_Career_Item_Text_Name_Content = {Text = "Receber"},
  PanelText_UI_Task_Popup_Career_New_Text_C_1_Content = {
    Text = "Progresso atual"
  },
  PanelText_UI_Task_Popup_Career_New_Text_C_Chapter_Award_Content = {
    Text = "Recompensa concluída"
  },
  PanelText_UI_Task_Popup_Career_Text_C_1_Content = {
    Text = "Progresso atual"
  },
  PanelText_UI_Task_Popup_Career_Text_C_Award_Content = {
    Text = "Recompensa concluída"
  },
  PanelText_UI_Task_Popup_Career_Text_C_Get_Content = {
    Text = "Recompensa Recebida"
  },
  PanelText_UI_Task_Popup_Career_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_Name_2_Content = {
    Text = "Receber tudo"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Task_Popup_Challenge2_Text_C_ReachName_Content = {
    Text = "\"Todas\" as conquistas completadas"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Info1_Content = {
    Text = "Aumentar o nível de investigação para obter recompensas"
  },
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Level1_Content = {Text = "Nível"},
  PanelText_UI_Task_Popup_Challenge_Item1_Text_C_Undone1_Content = {Text = "Incompleto"},
  PanelText_UI_Task_Popup_Challenge_Item1_Text_Name_Content = {Text = "Receber"},
  PanelText_UI_Task_Popup_Challenge_Item_Text_C_Info_Content = {
    Text = "Aumentar o nível de investigação para obter recompensas"
  },
  PanelText_UI_Task_Popup_Challenge_Item_Text_C_Level_Content = {Text = "Nível"},
  PanelText_UI_Task_Popup_Challenge_Item_Text_Name_Content = {Text = "Receber"},
  PanelText_UI_Task_Popup_Challenge_New_Text_C_1_Content = {
    Text = "Guardião do Segredo"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_2_Content = {
    Text = "Hora de gravação"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_3_Content = {
    Text = "Nível de Investigação"
  },
  PanelText_UI_Task_Popup_Challenge_New_Text_C_Title_Content = {
    Text = "Desbloquear conquista"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_1_Content = {Text = "Guardião"},
  PanelText_UI_Task_Popup_Challenge_Text_C_2_Content = {
    Text = "Hora de gravação"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_3_Content = {
    Text = "Nível de Investigação"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_OneKey_Content = {
    Text = "Receber com um clique"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_Reach_Content = {
    Text = "Que a Chave de Prata nos guie"
  },
  PanelText_UI_Task_Popup_Challenge_Text_C_Title_Content = {
    Text = "Certificado de Aluno"
  },
  PanelText_UI_Task_Popup_Entrust_New_Text_C_Award_Content = {
    Text = "Recompensa da missão"
  },
  PanelText_UI_Task_Popup_Entrust_New_Text_C_Special_Content = {
    Text = "Condições de despacho"
  },
  PanelText_UI_Team_Item_Awaker_List_Text_C_Disable_Content = {Text = "Desativar"},
  PanelText_UI_Team_Item_Awaker_List_Text_C_Help_Content = {
    Text = "Despertar de apoio de batalha"
  },
  PanelText_UI_Team_Item_MyTeam_List_Text_C_Current_Content = {Text = "Em batalha"},
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Guide_Content = {Text = "Recomendar"},
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Hint_Content = {
    Text = "*Cada Despertado só pode equipar uma Roda do Destino SSR"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Recommend_Content = {Text = "Recomendar"},
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Remove_Content = {
    Text = "Desinstalar com um clique"
  },
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Save_Content = {Text = "Salvar"},
  PanelText_UI_Team_Item_Secret_Contract_Text_C_Uninstall_Content = {
    Text = "Desinstalar com um clique"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Foundation_Content = {Text = "Atributos"},
  PanelText_UI_Team_Item_Secret_Props_Text_C_Lv_Content = {
    Text = "Conclusão de nível"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Refining_Content = {
    Text = "Progresso da transcrição"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Null_Content = {
    Text = "Sem efeitos de conjunto ativos"
  },
  PanelText_UI_Team_Item_Secret_Props_Text_C_Suit_Title_Content = {
    Text = "Efeito do Conjunto"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Added_Content = {
    Text = "Novo plano de pacto"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_2_Content = {
    Text = "Descarregar"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_3_Content = {Text = "Reforço"},
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Name_4_Content = {
    Text = "Equipamento"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Null_Content = {
    Text = "Nenhum pacto disponível para a parte atual"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Quantity_Content = {
    Text = "Quantidade de planos"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Save_Content = {
    Text = "Novo plano de pacto"
  },
  PanelText_UI_Team_Item_Suit_Bookmark_Text_C_Suit_Content = {
    Text = "Nenhum plano disponível"
  },
  PanelText_UI_Team_Item_Suit_Text_C_Current_Content = {
    Text = "Usando atualmente"
  },
  PanelText_UI_Team_Item_Talent_Text_C_Activate_Content = {Text = "Ativado"},
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Foundation_Content = {Text = "Atributos"},
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Lv_Content = {
    Text = "Conclusão de nível"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Refining_Content = {
    Text = "Progresso da transcrição"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Null_Content = {
    Text = "Sem efeitos de conjunto ativos"
  },
  PanelText_UI_Team_Item_Trinket_Detail_Text_C_Suit_Title_Content = {
    Text = "Efeito do Conjunto"
  },
  PanelText_UI_Team_Item_Weapon_Full_Text_C_Empty_Content = {
    Text = "Escolha de equipamento de roda de destino à esquerda"
  },
  PanelText_UI_Team_Item_Weapon_Full_Text_C_Not_Content = {Text = "Sem efeito"},
  PanelText_UI_Team_Panel_Awaker_Main_Text_C_Zhanli_Content = {
    Text = "Poder de combate"
  },
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Recommend_Content = {Text = "Recomendar"},
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Remove_Content = {
    Text = "Desinstalar com um clique"
  },
  PanelText_UI_Team_Panel_Edit_Suit_Text_C_Save_Content = {Text = "Salvar"},
  PanelText_UI_Team_Panel_Main_Popup_Team_Text_C_AffixInfo_Content = {
    Text = "Informações da equipe"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Activated_Content = {Text = "Ativado"},
  PanelText_UI_Team_Panel_Main_Text_C_Boundaries_Tips_Content = {
    Text = "Recomendação de Domínio"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Cost_Tips_Content = {
    Text = "Requisitos da equipe:"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Empty_Content = {
    Text = "Sem chave equipada"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Frequency_Content = {Text = "Vezes"},
  PanelText_UI_Team_Panel_Main_Text_C_Hint_Content = {
    Text = "*Após a conclusão, os Despertados, Rodas do Destino e Chaves usados não podem ser usados em outras zonas de Corrosão"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Lives_Desc_Content = {
    Text = "Usos restantes da Entidade de Conhecimento de Emergência:"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Name_1_Content = {Text = "Cancelar"},
  PanelText_UI_Team_Panel_Main_Text_C_Name_2_Content = {
    Text = "Apoio de batalha"
  },
  PanelText_UI_Team_Panel_Main_Text_C_NoActivate_Content = {
    Text = "Não ativado"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Prohibit_Content = {
    Text = "Chave desativada nesta fase"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Skill_Content = {
    Text = "Ordem de chave"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips2_Content = {
    Text = "Informações da equipe"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips_1_Content = {
    Text = "Apoio de batalha"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips_2_Content = {
    Text = "Apoio de batalha"
  },
  PanelText_UI_Team_Panel_Main_Text_C_Tips_Content = {
    Text = "Cancelar assistência"
  },
  PanelText_UI_Team_Panel_Main_Text_Career_Content = {
    Text = "Requer reino"
  },
  PanelText_UI_Team_Panel_Main_Text_Madness_Content = {
    Text = "Dificuldade de loucura disponível apenas para recompensas de primeiras finalizações"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Delete_Content = {
    Text = "Excluir plano"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Edit_Content = {
    Text = "Editar Plano"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Recommend_Content = {
    Text = "Equipamento recomendado"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Remove_Content = {
    Text = "Desinstalar com um clique"
  },
  PanelText_UI_Team_Panel_Trinket_Equip_Text_C_Save_Content = {
    Text = "Salvar como plano"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Guide_Content = {Text = "Recomendar"},
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Hint_Content = {
    Text = "*Cada Despertado só pode equipar uma Roda do Destino SSR"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Name_2_Content = {
    Text = "Descarregar"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Name_3_Content = {
    Text = "Posição sobreposta"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Null_Content = {
    Text = "Nenhuma roda de destino disponível"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Title_Content = {
    Text = "Escolha roda do destino"
  },
  PanelText_UI_Team_Panel_Weapon_Equip_Text_C_Uninstall_Content = {
    Text = "Desinstalar com um clique"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Attribute_Content = {Text = "Atributos"},
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Name_Content = {
    Text = "Detalhes dos Despertos"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Title_Content = {
    Text = "Escolha despertar"
  },
  PanelText_UI_Team_Popup_Awaker_List_Text_C_Xx_Content = {
    Text = "Informações detalhadas"
  },
  PanelText_UI_Team_Popup_MyTeam_Awaker_List_Text_C_Name_Content = {Text = "Escolher"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name01_Content = {Text = "Caos"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name02_Content = {
    Text = "Mar Profundo"
  },
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name03_Content = {
    Text = "Carne e sangue"
  },
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Name04_Content = {Text = "Ultra"},
  PanelText_UI_Team_Popup_Prop_Award_Text_C_Title_Content = {
    Text = "Talento profissional"
  },
  PanelText_UI_Vindicate_Popup_Reward_Text_C_Task_Content = {
    Text = "Obtido automaticamente após completar o evento pela primeira vez"
  },
  PanelText_UI_Vindicate_Popup_Reward_Text_Title_Content = {
    Text = "Recompensa de Primeira Conclusão"
  },
  PanelText_UI_Vx_Battle_Chaowei_Butter_Text_C_ExtraTurn_Content = {
    Text = "Turno extra"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_1_Normal_Content = {
    Text = "Ordenação de empilhamento"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_1_Select_Content = {
    Text = "Ordenação de empilhamento"
  },
  PanelText_UI_Weapon_Item_Select_List_Text_C_2_Normal_Content = {Text = "Ordem"},
  PanelText_UI_Weapon_Item_Select_List_Text_C_2_Select_Content = {Text = "Ordem"},
  PanelText_UI_Weapon_Item_Select_List_Text_No_Weapon2_Content = {
    Text = "Sem \"Roda do Destino\" para equipar"
  },
  PanelText__Text_C_Dress_Content = {
    Text = "Trocar roupa"
  },
  PanelText__Text_C_Dressing_Content = {Text = "Vestindo"},
  PanelText__Text_C_Empty_Content = {Text = "Desativado"},
  PanelText__Text_C_Goto_Content = {
    Text = "Ir para Comprar"
  },
  PanelText__Text_C_Have_Content = {Text = "Possuído"},
  PanelText__Text_C_Reveal_Content = {Text = "Esconder"}
})
return Text_PanelText
