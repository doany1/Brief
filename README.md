# Brief
It helps you to strengthen your methodology.

## What It Does
Brief is a CLI tool that records your CTF or lab command history and generates a structured post‑mortem report. It helps you review what you did, spot mistakes, and improve your workflow. The tool can:
1. Start a recording session and log commands with timestamps.
2. Append new terminal tabs to the same session log.
3. Analyze a session log and produce a Markdown + HTML report.
4. Label commands by terminal so multi‑tab work stays clear.
5. Provide a readable CLI help and report output for quick review.

## Who It Helps
Brief is built for:
1. CTF and lab learners who want feedback on their methodology.
2. Pen‑testing students who need repeatable workflows.
3. Anyone who wants a clean, time‑stamped command history and a post‑session summary.
4. OSCP/CPTS candidates looking to tighten their process under exam pressure.
5. Self‑taught learners who want mentor‑style feedback without a full course.

## How It Helps
Brief is especially useful for people building their methodology because it turns messy terminal activity into a clear, reviewable workflow. It helps you:
1. See the exact sequence of actions you took, with timestamps and context.
2. Identify gaps in enumeration, validation, and exploitation steps.
3. Compare your current approach against a more disciplined, repeatable process.
4. Build habits around structured recon, targeted testing, and clean post‑exploitation.
5. Reduce trial‑and‑error by pointing out repeated or low‑value actions.

## Example Report Value
The AI report is designed to feel like a strict mentor review. It breaks down your session line‑by‑line, highlights repeated mistakes, and provides a corrected workflow with better commands and sequencing. For learners preparing for OSCP or CPTS, this is especially valuable because it turns raw command history into a clear methodology review and a reusable playbook.

## How AI Is Used
Brief uses an AI model to read your recorded command log and generate a detailed, step‑by‑step analysis. It:
1. Highlights mistakes and weak assumptions.
2. Suggests better commands and sequencing.
3. Explains reasoning so you can learn and avoid repeating errors.
4. Produces a mentor‑style critique with actionable corrections.
5. Outputs a clean Markdown + HTML report you can review or share.

The AI output is saved as:
1. A Markdown report for easy reading.
2. An HTML report for a polished, shareable summary.

## Quick Start Guide
When you’re preparing for OSCP, CPTS, or any hands‑on security exam, one question comes up after you solve a box:

“Was there a cleaner way to do this — or did I just get lucky?”

Brief is built for that exact gap. Not to tell you how to solve boxes, but to help you understand how you think while solving them.

After a box, most people read a walkthrough and try to copy the author’s methodology. That helps, but it hides something important: your own footprint. Where you went into rabbit holes. What you ignored. What you brute‑forced instead of reasoning. What patterns you consistently miss.

Brief analyzes your command history step by step and reflects it back to you like a strict but helpful mentor. It shows you:
1. Where your methodology broke down.
2. Where you chased noise instead of signal.
3. Where you already had enough information but didn’t recognize it.
4. What habits slow you down under exam pressure.

This is how you build a strong, repeatable methodology — not by memorizing exploits, but by refining decision‑making.

Over time, Brief gives you something walkthroughs never can: a clear view of how you approach problems, not just how others solved them.

## Installation
1. Download the script
```bash
git clone https://github.com/doany1/brief.git
cd brief
chmod +x brief.py
```

2. Move to PATH (optional)
```bash
echo $PATH
sudo mv brief.py /usr/local/bin/brief
```

3. Get Hugging Face API token
1. Visit: https://huggingface.co/settings/tokens
2. Click "New token"
3. Click "Read"
4. Click "Create Token"
5. Copy the token (starts with `hf_`)

4. Set your API token
```bash
export HF_TOKEN=hf_xxxxxxxxxxxxxxxxx
```

5. Make it permanent (optional)
```bash
echo 'export HF_TOKEN=hf_xxxxxxxxxxxxxxxxx' >> ~/.bashrc
source ~/.bashrc
```

## Basic Commands
1. Start recording a session
```bash
brief --start
```

2. List the most recent session
```bash
brief --list
```

3. Analyze the most recent session
```bash
brief --latest
```

4. Analyze a specific session
```bash
brief --ingest ~/.brief/sessions/session-name.md
```

5. View help
```bash
brief --help
```

6. Check version
```bash
brief --version
```

## File Locations
All data stored in `~/.brief/`:
```text
~/.brief/
├── sessions/           # Your command logs
│   └── session-name.md
└── outputs/            # AI analysis reports
    └── session-name.analysis.md
```

## Quick Workflow
```bash
# 1. Start recording
brief --start
Enter name for file: htb-example-box

# 2. Work on your challenge
# ... do your work ...

# 3. Stop recording
exit

# 4. Get AI analysis
brief --latest

# 5. Read the analysis
cat ~/.brief/outputs/htb-example-box.analysis.md
```


Commands not recording?
1. Make sure you started with `brief --start`.
2. Work within that shell session (or `brief --use` in a new tab).

Analysis incomplete?
1. Ensure the full session was recorded.
2. Check that you have internet access for API calls.

## Privacy & Security
1. All session data is stored locally on your machine.
2. Data is only sent to Hugging Face when you run `--ingest` or `--latest`.
3. Your API token is used only to authenticate with Hugging Face.
4. Review session files before ingesting if they contain sensitive data.
