# Priston Helper

**Priston Helper** é uma ferramenta leve e altamente otimizada criada em AutoHotkey para automatizar o uso de poções e auto click no jogo **Priston Tale**. Suporta configuração dinâmica das posições e cores das barras de HP, MP e STM, permitindo total compatibilidade com diferentes resoluções e interfaces.

---

## ✨ Funcionalidades

- 🧪 **Auto Pot**: Detecta mudanças de cor nas barras de HP, STM e MP para uso automático de poções.
- 🖱️ **Auto Click (AC)**: Simula cliques com o botão direito do mouse com suporte a dois modos:
  - `Fast` (0.18s)
  - `Slow` (2s)
- 🔄 **Troca dinâmica de modo**: Alterne facilmente entre modo rápido e lento com atalhos.
- ⚙️ **Configuração in-game**: Configure as barras com precisão por meio de atalhos, clicando diretamente sobre as cores da HUD.
- 💾 **Armazenamento persistente**: Salva configurações no arquivo `PristonHelper.ini`.
- 📌 **Tooltip dinâmico**: Mostra o estado atual como "Potion", "AC:Fast", "AC:Slow", etc.
- 🎯 **Funcionamento inteligente**: O script só age quando o jogo está em foco.
- 🔒 **Seguro e leve**: Nenhum processo ativo quando desativado. O Auto Click pausa automaticamente ao segurar a tecla `A`.

---

## 🔧 Atalhos

| Atalho            | Ação                                   |
| ----------------- | -------------------------------------- |
| Ctrl + Numpad 1   | Ativar o Priston Helper                |
| Ctrl + Numpad 0   | Desativar completamente                |
| Ctrl + Numpad 2   | Ativar/alternar modo Auto Click rápido |
| Ctrl + Numpad 3   | Ativar/alternar modo Auto Click lento  |
| Ctrl + Numpad 7   | Configurar barra de HP                 |
| Ctrl + Numpad 8   | Configurar barra de STM                |
| Ctrl + Numpad 9   | Configurar barra de MP                 |
| Segurar tecla "A" | Pausar temporariamente o Auto Click    |

---

## 🖼️ Como configurar as barras (HP / STM / MP)

1. **Desative o sistema** com `Ctrl + Numpad 0`.
2. Pressione o atalho de configuração desejado:
   - `Ctrl + Numpad 7`: HP
   - `Ctrl + Numpad 8`: STM
   - `Ctrl + Numpad 9`: MP
3. Um Tooltip exibirá a posição do mouse e a cor capturada.
4. **Clique com o botão esquerdo** para salvar a configuração.
5. **Clique com o botão direito** para cancelar.

---

## 📁 Exemplo de estrutura do arquivo INI

```ini
[HP]
X=412
Y=1370
Color=0xA40800

[STM]
X=385
Y=1426
Color=0x179C10

[MP]
X=596
Y=1425
Color=0x0121B6
```

---

## 📌 Observações

- O script age apenas quando o Priston Tale estiver em foco.
- Ao abrir pela primeira vez, cria automaticamente o arquivo `PristonHelper.ini`.
- As configurações de cor e coordenadas podem ser feitas sem abrir janelas adicionais.
- O modo lento respeita exatamente 2s entre cliques, mesmo com timers ativos.

---

## 💡 Requisitos

- Arquivo `.exe` para rodar diretamente (recomendado).
- Ou [AutoHotkey v1.1+](https://www.autohotkey.com/) instalado para rodar o `.ahk`.

---

## 📜 Licença

Distribuído gratuitamente para fins pessoais. Este projeto não é afiliado oficialmente ao jogo Priston Tale.
