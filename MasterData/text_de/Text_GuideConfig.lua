__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_GuideConfig = readonly({
  GuideConfig_10_Content_1 = {
    Text = "Vor uns stand ein <RedQuality:silbernes sechswertiges Wesen>, das blendendes Licht ausstrahlte"
  },
  GuideConfig_11_Content_1 = {
    Text = "Wir können Ihm direkt gegenübertreten ... oder die hier herumlaufenden Monster beseitigen und nach einem Verbindungspunkt suchen. Es ist an der Zeit, dass du eine Entscheidung triffst, Hüter"
  },
  GuideConfig_12_Content_1 = {
    Text = "Halte die Befehlskarte und ziehe sie nach oben, um einen Befehl zu erteilen"
  },
  GuideConfig_13_Content_1 = {
    Text = "Der Feind wird einen ANG verursachen, der tödlichen Schaden anrichtet. Gib die VERTsbefehle aus, Hüter!"
  },
  GuideConfig_14_Content_1 = {
    Text = "Das wiederholte Einsetzen des Königin-Schwerts macht die ANGe schneller. Willst du es ausprobieren, um den Gegner zu besiegen?"
  },
  GuideConfig_15_Content_1 = {
    Text = "Das Ausführen eines ANGs befehls erhält Wut, wenn die Wut voll ist, kann eine starke Wutausbruch freigesetzt werden"
  },
  GuideConfig_1_Content_1 = {
    Text = "Hüter des Geheimnisses, du kannst jetzt weiter erkunden"
  },
  GuideConfig_2_Content_1 = {
    Text = "Das ist der Verbindungspunkt von Mythag, mit dem Silberschlüssel in Resonanz kann das Leben wiederhergestellt werden, das ist genau das, was wir brauchen"
  },
  GuideConfig_34_Content_1 = {
    Text = "Aktuell im Kampftraining, noch Befehlskarten verfügbar. Nach dem Training frei spielen"
  },
  GuideConfig_35_Content_1 = {
    Text = "Aktuell im Kampftraining, noch Befehlskarten verfügbar. Nach dem Training frei spielen"
  },
  GuideConfig_36_Content_1 = {
    Text = "Aktuell im Kampftraining, noch Befehlskarten verfügbar. Nach dem Training frei spielen"
  },
  GuideConfig_37_Content_1 = {
    Text = "Aktuell im Kampftraining, noch Befehlskarten verfügbar. Nach dem Training frei spielen"
  },
  GuideConfig_38_Content_1 = {
    Text = "Aktuell befindest du dich in der Kampftrainingsphase, es gibt noch eine Aelius-Eruption, die verwendet werden kann. Nach Abschluss des Trainings kannst du frei agieren"
  },
  GuideConfig_39_Content_1 = {
    Text = "Aktuell befindest du dich in der Kampftrainingsphase, es gibt noch eine Aelius-Eruption, die verwendet werden kann. Nach Abschluss des Trainings kannst du frei agieren"
  },
  GuideConfig_3_Content_1 = {
    Text = "Besiege <RedQuality:den tobenden Wal> so schnell wie möglich, ich will nicht noch einmal so eine Tragödie erleben"
  },
  GuideConfig_40_Content_1 = {
    Text = "Aktuell befindest du dich in der Kampftrainingsphase, es gibt noch eine Aelius-Eruption, die verwendet werden kann. Nach Abschluss des Trainings kannst du frei agieren"
  },
  GuideConfig_41_Content_1 = {
    Text = "Aktuell befindest du dich in der Kampftrainingsphase, es gibt noch eine Aelius-Eruption, die verwendet werden kann. Nach Abschluss des Trainings kannst du frei agieren"
  },
  GuideConfig_42_Content_1 = {
    Text = "Aktuell im Kampftraining, noch Schlüsselbefehle verfügbar. Nach dem Training frei spielen"
  },
  GuideConfig_47_Content_1 = {
    Text = "Das Chaos-Reich hat eine starke Resonanz mit dem Silberschlüssel und gewährt jede Runde 250 Keyflare, um dir zu helfen, deine Posse schneller freizugeben. Wenn sich keine Erwecker aus anderen Reichen in deinem Team befinden, erhältst du beim Betreten des Levels außerdem eine Silberne Schöpfung. Nutze das Relikt, um deine Feinde zu besiegen."
  },
  GuideConfig_47_TipsTitle_1 = {Text = "Chaosreich"},
  GuideConfig_49_Content_1 = {
    Text = "Das Aequor-Reich erzeugt zu Beginn des Kampfes 1 Tentakel. Der Tentakel greift am Ende jeder Runde den Feind in der vorderen Reihe an. Tiefseewachkörper können dem Tentakel verschiedene Verstärkungen verleihen. Du kannst den aktuellen Tentakelschaden über den Wert unterhalb des Tentakel-Symbols überprüfen."
  },
  GuideConfig_49_TipsTitle_1 = {
    Text = "Aequor-Reich"
  },
  GuideConfig_4_Content_1 = {
    Text = "Schwarze Stempel können als Opfer an das Gebiet <Yellow: D-Mark> gegeben werden, um verschiedene <Yellow: Relikte> zu erhalten, die im Kampf von großem Nutzen sind"
  },
  GuideConfig_55_Content_1 = {
    Text = "Das Fleisch-Reich akkumuliert jede Runde Embryofusion und Blutroter Ofen — je niedriger deine LP, desto schneller die Akkumulation. Wenn der Fusionsgrad sein Maximum erreicht, wird ein Embryo erzeugt und auf deine Hand gelegt. Embryos können direkt eingesetzt werden, um den entsprechenden Fleisch-Erwachungskörper-Aliemus und Temporäre Kritische Trefferquote zu gewähren; oder sie können von einem Fleisch-Reich-Erwecker durch Verherrlichung Verschlungen werden, um zusätzliche Effekte auszulösen."
  },
  GuideConfig_55_TipsTitle_1 = {
    Text = "Fleischreich"
  },
  GuideConfig_57_Content_1 = {
    Text = "Nutze den „Blutroten Ofen\" zur LP-Wiederherstellung, um Angriffen standzuhalten!"
  },
  GuideConfig_58_Content_1 = {
    Text = "Wenn ein Fleisch-Erwachungskörper Verherrlichung freigibt, kann er Embryos in deiner Hand verschlingen, um den Verherrlichungs-Effekt zu verstärken. Gib das Auge der Ewigkeit frei und löse Verschlingen aus!"
  },
  GuideConfig_5_Content_1 = {
    Text = "<Yellow: D-Mark> entdeckt, investiere das angesammelte schwarze Siegel"
  },
  GuideConfig_60_Content_1 = {
    Text = "Im Ultra-Reich wird jede Runde eine temporäre Kopie der ersten gespielten Befehlskarte in den Hyperraum gelegt. Wenn der Hyperraum sein Limit erreicht, kannst du eine neue Runde beginnen. In dieser neuen Runde ziehst du keine Karten; stattdessen werden die Karten aus dem Hyperraum in deine Hand gelegt."
  },
  GuideConfig_60_TipsTitle_1 = {
    Text = "Ultra Reich"
  },
  GuideConfig_6_Content_1 = {
    Text = "Das ist <Yellow: Relikt>, aus dem Bereich des Mysteriums, und du wirst bald seine Kraft spüren können. Leider zerfällt das Relikt, wenn es den Bereich verlässt"
  },
  GuideConfig_7_Content_1 = {
    Text = "Es scheint, dass es vorne ein unerwartetes <Yellow:Ereignis> gibt, schau mal vorbei. Vielleicht kannst du unerwartete Verstärkungen erhalten... obwohl das manchmal mit Kosten verbunden ist."
  },
  GuideConfig_8_Content_1 = {
    Text = "Es scheint noch Feinde vor uns zu geben"
  },
  GuideConfig_9_Content_1 = {
    Text = "Das ist ein einseitiger Durchgang, der zum Untergrundsaal führen sollte. Lass uns gehen und unsere Mission erfüllen"
  }
})
return Text_GuideConfig
