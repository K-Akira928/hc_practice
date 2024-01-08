const commandGetDate = () => {
  if (process.argv[2] === '-m' && process.argv[3] >= 1 && process.argv[3] <= 12) {
    const date = new Date();
    date.setMonth(process.argv[3] - 1, 1);
    return date;
  }

  if (process.argv[2] === '-m' && process.argv[3] > 1 || process.argv[3] < 12) {
    throw new SyntaxError(`${process.argv[3]} is neither a month number (1..12) nor a name`);

  } else {
    const nowDate = new Date();
    nowDate.setDate(1);
    return nowDate;
  }
};

const getLastDate = (date) => {
  const lastDate = new Date(date.getTime());
  lastDate.setMonth(lastDate.getMonth() + 1);
  lastDate.setDate(0);
  return lastDate;
};

const modifyDateDays = (date, lastDate) => {
  const days = [...Array(lastDate.getDate())];
  const spacingCount = Number(date.getDay());

  for (let i = 0; i < days.length; i++) {
    days[i] = (' ' + (i + 1).toString()).slice(-2);
  }

  for (let i = 0; i < spacingCount; i++) days.unshift('  ');

  return days;
};

const displayCalendar = (date, lastDate) => {
  const days = modifyDateDays(date, lastDate);
  console.log(`     ${date.getFullYear()}年 ${date.getMonth() + 1}月     `);

  console.log('日 月 火 水 木 金 土');

  days.forEach((day, index) => {
    process.stdout.write(day + ' ');
    if ((index + 1) % 7 === 0) console.log();
  });

  console.log();
};

const date = commandGetDate();
const lastDate = getLastDate(date);

displayCalendar(date, lastDate);
